source ~/.bash/completions
source ~/.bash/paths
source ~/.bash/config
source ~/.aliases

# use .localrc for settings specific to one system
[[ -s ~/.localrc ]] && source ~/.localrc

PATH=$HOME/.rvm/bin:$PATH # Add RVM to PATH for scripting

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
