source ~/.zshenv
source ~/.zsh/config

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc

#PATH="$HOME/.rvm/bin:/usr/local/bin:$PATH:$HOME/bin:/usr/local/heroku/bin"
PATH="$PATH:/usr/local/heroku/bin"
