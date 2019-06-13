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
alias cdt='cd $(mktemp -d -t XXXX-tmp)'
alias hc='herbstclient'
alias sc='systemctl'
alias fx='less -FXR' #make less look like cat but with raw ansi
alias lsl='ls -lhFA | fx'
alias xcp='xclip -selection clipboard'
alias tracert='traceroute'
alias rot13='tr N-ZA-Mn-za-m A-Za-z'
alias jarva='java -jar'
alias castv="castnow --tomp4 --ffmpeg-vcodec copy"
alias wget="wget -c"

# dmesg with colored human-readable dates
alias dmesgc="dmesg -T | sed -e 's|\(^.*'`date +%Y`']\)\(.*\)|\x1b[0;34m\1\x1b[0m - \2|g'"
alias dmesg="dmesg -HP"
alias info="info --vi-keys"

# clipboard
alias getclip="xclip -selection clipboard -o"
alias setclip="xclip -selection clipboard -i"
alias clipwget="xclip -o -sel clip | xargs wget"

# makes aliases work with sudo
alias sudo='sudo '

# sum numbers in lines from stdin
alias suml="awk '/^[0-9]{1,}$/ { s += \$0 } END { print s}'"
alias sumlf="awk '/^[0-9,.]{1,}$/ { s += \$0 } END { printf \"%f\", s}'"

# show ip on network cards ( mostly like 'ip ro' )
alias ipa="ip -o -4 a | awk 'NR>1 { sub(/\/.*/,\"\",\$4);print \$4,\"on\",\$2 }'"
# external ip checker
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"

# Neat functions
# myip() { curl -s checkip.dyndns.org|grep -o '[0-9.]\{7,15\}'; }
# colored diff output. $1 = red, $2 = green
cdiff() { diff -U3 $1 $2 |sed -e 's/^+/\x1b\[32m /;s/^-/\x1b[31m /;s/$/\x1b[0m/'; }
# print the n biggest memory hogs
memhogs() { ps aux | awk '$11!~/\[*\]/ {print $6/1024" MB\t"$2"\t"$11,$12,$13,$14}' |sort -gr|head -$1; }
# copy to RAM
bi() {	test -d "$1" && cp -ra "$1" /dev/shm; cd /dev/shm; }
# print nth line of stdin (ls -l|nth 3)
nth() {(for ((x=0;x<=$1;x++)) ; do read -r; done ; echo "$REPLY")}
# open file
o() { xdg-open "$@" & }
# make and cd to dir
cdm() { mkdir -p "$1" && cd "$1"; }
# inverse grep/strip comments and blank lines
gv() { grep -v -e "${1:-^#}" -e "^\$"; }
# watch a a file for changes
fwatch() { while true; do cat "${1:-.}" || break; date "+%nStarting %F %T."; inotifywait -e modify "$1"; done; }

# Arch specific aliases:
# prefer powerpill for package management
type -p powerpill > /dev/null && alias p='sudo powerpill' || alias p='sudo pacman'
# check which package something belongs to
alias powns='pacman -Qo'
# show executables in package
pexes() { pacman -Q "$1" && for f in $(pacman -Ql "$1"); do [[ -x "$f" && -f "$f" ]] && echo "$f";  done; }

#remove stuff from bash command history
forget() { 
	c=$(grep -c "$1" $HISTFILE) && ( sed -i '/'"$1"'/d' $HISTFILE; 
	echo "Found and removed $c occurences of $1" ) || echo "$1 not in history"; }

# make there commands run in background automatically
soffice() { command soffice "$@" & }
firefox() { command firefox "$@" & }
xpdf() { command xpdf "$@" & }
vlc() { command vlc "$@" & }
gvim() { command gvim "$@" & }
thunar() { command thunar "$@" & }
mecp() { scp "$@" ${SSH_CLIENT%% *}:Desktop/; }

# Useless functions :P
# matrix simulator
hax() { echo -ne "\e[34m" ; while true ; do sleep 0.01; echo -ne "\e[$(($RANDOM % 2 + 1))m"; tr -c "[:alpha:]" " " < /dev/urandom |dd count=1 bs=50 2> /dev/null; done }

# draw ascii box around $1
box() { t="LL$1RR";c=${2:-#}; echo ${t//?/$c}; echo "$c $1 $c"; echo ${t//?/$c}; } #From bartonski

# random BOFH Excuse
alias bofh='curl -s towel.blinkenlights.nl:666|tr -d "[:cntrl:]"|sed "s/^.*=//;s/$/\n/"'

# extract all the files
extract() { 
	if [ -z "$1" ]
	then
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f "$1" ] ; then
        case $1 in
          *.tar.gz)    tar xvzf ../$1    ;;
          *.tar.bz2)   tar xvjf ../$1    ;;
          *.tar.xz)    tar xvJf ../$1    ;;
          *.lzma)      unlzma ../$1      ;;
          *.bz2)       bunzip2 ../$1     ;;
          *.rar)       unrar x -ad ../$1 ;;
          *.gz)        gunzip ../$1      ;;
          *.tar)       tar xvf ../$1     ;;
          *.tgz)       tar xvzf ../$1    ;;
          *.tbz2)      tar xvjf ../$1    ;;
          *.zip)       unzip ../$1       ;;
          *.7z)        7z x ../$1        ;;
          *.xz)        unxz ../$1        ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "$1 - file does not exist"
    fi
fi
}
