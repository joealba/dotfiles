if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

#source ~/.aliases
source ~/.bash/aliases
source ~/.bash/completions
source ~/.bash/paths
source ~/.bash/config

# use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi

[[ -s "/Users/joealba/.rvm/scripts/rvm" ]] && source "/Users/joealba/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
