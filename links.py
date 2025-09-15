#!/usr/bin/python3

from argparse import ArgumentParser
from collections.abc import Sequence
from functools import partial
from pathlib import Path

Link = tuple[Path, Path]


def attrget(attr: str, o: object):
    return getattr(o, attr)


def parse_link(pkg: Path, line: str) -> Sequence[Link]:
    if not line.find("="):
        raise ValueError("Not a valid path link")

    src, dst = line.split("=", maxsplit=1)
    dst = dst.strip()
    src, dst = map(Path, (src, dst))
    src, dst = map(Path.expanduser, (src, dst))

    if "*" in str(src):
        srcs = pkg.glob(str(src))
        srcs = filter(lambda n: ".links" not in str(n), srcs)
        srcs = tuple(map(Path.absolute, srcs))
        names = map(partial(attrget, "name"), srcs)
        dsts = map(partial(str(dst).replace, "%"), names)

        dsts = map(Path, dsts)
        dsts = map(Path.absolute, dsts)
        return tuple(zip(srcs, dsts))

    return ((Path.absolute(pkg / src), dst.absolute()),)


def show_pkg(path: str):
    pkg_path = Path(path)
    file_path = pkg_path / ".links"

    with open(str(file_path), "r") as f:
        print(f"=== PKG: {pkg_path} ===")
        for line in f:
            if not line.strip():
                continue

            links = parse_link(pkg_path, line)
            for src, dst in links:
                print(f"{src} -> {dst}")
        print("=== END PKG ===")


def undo_pkg(path: str):
    links = get_pkg_links(path)
    for _, dst in links:
        bak_file = Path(str(dst) + ".bak")

        if dst.is_symlink() and bak_file.exists():
            print(f"Restoring {bak_file} -> {dst}")
            dst.unlink()
            bak_file.rename(dst)
        elif dst.is_symlink():
            print(f"Removing symlink {dst}")
            dst.unlink()
        else:
            print(f"Skipping {dst}")


def get_pkg_links(path: str) -> list[Link]:
    pkg_path = Path(path)
    file_path = pkg_path / ".links"
    out: list[Link] = []

    with open(str(file_path), "r") as f:
        for line in f:
            if not line.strip():
                continue

            links = parse_link(pkg_path, line)
            out.extend(links)
    return out


def filter_links(srcdst: tuple[Path, Path]) -> bool:
    src, dst = srcdst
    if dst.exists() and dst.is_symlink() and dst.readlink() == src:
        print(f"{dst} is already linked! Skipping!")
        return False

    return True


def create_link(src: Path, dst: Path):
    if dst.exists():
        bak_file = Path(str(dst) + ".bak")
        if bak_file.exists():
            raise RuntimeError(f"Backup file already exists for {dst}")
        print(f"{dst} already exists! Moving to {bak_file}.")
        bak_file.hardlink_to(src)
        assert bak_file.exists()
        dst.unlink()
    elif not dst.parent.exists():
        dst.parent.mkdir(parents=True)

    dst.symlink_to(src)


def show(*pkgs: str) -> int | None:
    for pkg in pkgs:
        show_pkg(pkg)


def undo(*pkgs: str) -> int | None:
    for pkg in pkgs:
        undo_pkg(pkg)


def install(*pkgs: str) -> int | None:
    links: list[Link] = []
    for pkg in pkgs:
        links.extend(get_pkg_links(pkg))

    links = list(filter(filter_links, links))

    if not links:
        print("Nothing to do!")
        return 0

    for src, dst in links:
        if not src.exists():
            print(f"Source file {src} is does not exist! Aborting!")
            return 1

        print(f"{src} -> {dst}", end="")
        if dst.exists():
            print(" (conflict will create backup)")
        else:
            print()

    prompt = input("Proceed to link these files? [Y/n] ")
    if prompt not in ("Y", "y", "yes", "ye", ""):
        return 1

    for src, dst in links:
        create_link(src, dst)


def main():
    parser = ArgumentParser()
    parser.add_argument(
        "--show", action="store_true", default=False, help="Show pkg info"
    )
    parser.add_argument(
        "--undo", action="store_true", default=False, help="Undo an installation"
    )

    parser.add_argument("packages", nargs="+", help="Packages to operate on")

    args = parser.parse_args()

    if args.show:
        return show(*args.packages)
    elif args.undo:
        return undo(*args.packages)
    else:
        return install(*args.packages)


if __name__ == "__main__":
    try:
        exit(main())
    except Exception as e:
        print(f"Error occurred ({type(e).__name__}): {' '.join(map(str, e.args))}")

        DEBUG = False

        if DEBUG:
            raise e

        exit(1)
