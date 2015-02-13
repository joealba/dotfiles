source ~/.zshenv
source ~/.zsh/config

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc

PATH="$PATH:/usr/local/share/npm/bin:/usr/local/oracle:/usr/local/heroku/bin"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting


export ORACLE_HOME="/usr/local/oracle"
#export DYLD_LIBRARY_PATH=$ORACLE_HOME
export NLS_LANG="en"
