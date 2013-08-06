source ~/.bash/completions
source ~/.bash/paths
source ~/.bash/config
source ~/.aliases

# use .localrc for settings specific to one system
[[ -s ~/.localrc ]] && source ~/.localrc

PATH=$HOME/.rvm/bin:$PATH # Add RVM to PATH for scripting
