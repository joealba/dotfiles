source ~/.zshenv
source ~/.zsh/config

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc

PATH=$PATH:$HOME/bin:$HOME/.rvm/bin # Add RVM to PATH for scripting
