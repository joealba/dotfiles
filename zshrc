if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

source ~/.zsh/omz
source ~/.zsh/completions
source ~/.zsh/paths
source ~/.zsh/config

# use .localrc for settings specific to one system
# if [ -f ~/.localrc ]; then
#   source ~/.localrc
# fi
