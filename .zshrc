# .zshrc

SHELL="$(which zsh)"

if [[ -f "$HOME/.profile" ]]; then
    source "$HOME/.profile"
fi

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting