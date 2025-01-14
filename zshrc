source ~/.zshenv
source ~/.zsh/config
source ~/.profile

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc

export PATH="$PATH:/usr/local/share/npm/bin:/usr/local/oracle:/usr/local/heroku/bin"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="/usr/local/opt/postgresql@9.5/bin:$PATH"

. /opt/homebrew/opt/asdf/libexec/asdf.sh
eval "$(direnv hook zsh)"
