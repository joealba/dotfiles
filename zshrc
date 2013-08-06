source ~/.zshenv
source ~/.zsh/config

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc

PATH=$PATH:$HOME/.rvm/bin:$HOME/bin # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH="$PATH:/usr/local/heroku/bin"
