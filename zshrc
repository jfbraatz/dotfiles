#export PATH=/proj/arcesium/haskell/setup/current/bin:$PATH:/usr/local/bin
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -c"
export VISUAL="emacsclient -c"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.shell_prompt.sh

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey '^R' history-incremental-search-backward

eval `dircolors ~/.dircolors.ansi-dark`
alias ls='ls --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
stty -ixon


#tmux attach &> /dev/null

if [[ ! $TERM =~ screen ]]; then
#    exec tmux
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/jonbraatz/Distributed Systems/google-cloud-sdk/path.zsh.inc' ]; then source '/home/jonbraatz/Distributed Systems/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/jonbraatz/Distributed Systems/google-cloud-sdk/completion.zsh.inc' ]; then source '/home/jonbraatz/Distributed Systems/google-cloud-sdk/completion.zsh.inc'; fi
