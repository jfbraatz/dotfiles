export PATH=$PATH:/usr/local/bin

source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
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
eval `dircolors ~/dircolors-solarized/dircolors.ansi-dark`
alias ls='ls --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
stty -ixon

#tmux attach &> /dev/null

if [[ ! $TERM =~ screen ]]; then
#    exec tmux
fi
