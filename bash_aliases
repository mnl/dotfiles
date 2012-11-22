#Aliases moved to separate file

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# misc aliases
alias du='du -kh'       # Makes a more readable output.
alias df='df -kTh'

alias xcp='xclip -selection clipboard'
alias tracert='traceroute'
alias rot13='tr N-ZA-Mn-za-m A-Za-z'

