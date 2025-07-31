test -z "$PROFILEREAD" && . /etc/profile || true

[ -f "$HOME/.rye/env" ] && source "$HOME/.rye/env"
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

command -v z &> /dev/null && alias cd=z

function automacs() {
    if /usr/bin/emacsclient -eu "server-socket-dir" &> /dev/null; then
        /usr/bin/emacsclient -r -u $@
    else
        /usr/bin/emacs $@
    fi
}

if /usr/bin/emacsclient -eu "server-socket-dir" &> /dev/null; then
    export EDITOR="emacs"
elif command -v micro &> /dev/null; then
    export EDITOR="micro"
else
    export EDITOR="nano"
fi

alias xd=chid
alias mkvenv="python3 -m venv .venv"
alias py=python3
alias edit=$EDITOR
alias emacs="automacs -t"

export PATH="/home/gamer/.local/bin:$PATH"
export PATH="/home/gamer/.turso:$PATH"
export PATH="/opt/cuda/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

export LIBVIRT_DEFAULT_URI="qemu:///system"
alias gpu-connect="/etc/libvirt/hooks/qemu.d/win10/release/end/revert.sh"
alias gpu-disconnect="/etc/libvirt/hooks/qemu.d/win10/prepare/begin/start.sh"
