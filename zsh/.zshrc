

export ZSH="$HOME/.oh-my-zsh"


# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="itchy"

CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="false"
zstyle ':omz:update' mode reminder
COMPLETION_WAITING_DOTS="true"


function zsh-ensure() {
    repo="${2:-zsh-users}"
    
    if [ -z "$1" ]; then
        echo -e "Usage:   zsh-ensure <plugin-repo-name> [<repo-owner>]"
        echo -e ""
        echo -e "Example: zsh-ensure zsh-syntax-highlighting"
        echo -e "         zsh-ensure zsh-fzf-history-search joshskidmore"
    fi

    if ! [ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$1" ]; then
        git clone "https://github.com/$repo/$1" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$1"
    fi
}


plugins=(
    python
    git
    zsh-completions
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-fzf-history-search
)

zsh-ensure zsh-autosuggestions
zsh-ensure zsh-syntax-highlighting
zsh-ensure zsh-completions
zsh-ensure zsh-fzf-history-search joshskidmore


source $ZSH/oh-my-zsh.sh

if command -v fortune &> /dev/null; then
    fortune
else 
    echo -e "Install fortune dumb bass"
fi

# source other stuff
test -f "$HOME/.profile" && source "$HOME/.profile"
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
