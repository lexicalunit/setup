# .bashrc

SHELL="$(which bash)"

if [[ -f "$HOME/.profile" ]]; then
    source "$HOME/.profile"
fi