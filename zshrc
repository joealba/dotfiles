fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)

source ~/.zsh/functions
source ~/.zsh/completions
source ~/.zsh/prompt
source ~/.aliases
source ~/.profile

export EDITOR="vim"

bindkey "^R" history-incremental-search-backward
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word

setopt complete_in_word
autoload -U select-word-style
select-word-style bash

HISTFILE=~/.zsh_history
HISTSIZE=4000
SAVEHIST=4000
setopt extendedglob notify append_history inc_append_history COMPLETE_IN_WORD
unsetopt CORRECT CORRECT_ALL

eval "$(direnv hook zsh)"

[[ -f ~/.localrc ]] && . ~/.localrc
