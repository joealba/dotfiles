source ~/.bash/completions
source ~/.bash/paths
source ~/.bash/config
source ~/.aliases

# use .localrc for settings specific to one system
[[ -s ~/.localrc ]] && source ~/.localrc

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
