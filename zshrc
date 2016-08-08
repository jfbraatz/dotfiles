export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/gcc-arm-none-eabi/bin

source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.shell_prompt.sh

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')

bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
alias ls='ls -G'
alias ..='cd ..'
alias ...='cd ../..'
stty -ixon

tmux attach &> /dev/null

if [[ ! $TERM =~ screen ]]; then
    exec tmux
fi
