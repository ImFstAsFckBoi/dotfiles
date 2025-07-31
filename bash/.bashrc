


if command -v fortune &> /dev/null; then
    fortune
else 
    echo -e "Install fortune dumb bass"
fi

# source other stuff
test -f "$HOME/.profile" && source "$HOME/.profile"
eval "$(fzf --bash)"
eval "$(zoxide init bash)"
eval "$(starship init bash)"
