# Mickes .bashrc
# Updated on maj 21 01:13:23 CEST 2012

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
[xkE]term*|urxvt*|cygwin|screen*|dtterm)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1";
	titlestring='\e]0;h%s\007';;
*)
    ;;
esac
# trim dirs to 3
PROMPT_DIRTRIM=2

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# neat functions
myip() { curl -s checkip.dyndns.org|grep -o '[0-9.]\{7,15\}'; }
hax() { echo -ne "\e[34m" ; while true ; do sleep 0.01; echo -ne "\e[$(($RANDOM % 2 + 1))m"; tr -c "[:alpha:]" " " < /dev/urandom |dd count=1 bs=50 2> /dev/null; done }
#colored diff output. $1 = red, $2 = green
cdiff() { diff -U3 $1 $2 |sed -e 's/^+/\x1b\[32m /;s/^-/\x1b[31m /;s/$/\x1b[0m/'; }
#print the n biggest memory hogs
memhogs() { ps aux | awk '$11!~/\[*\]/ {print $6/1024" MB\t"$2"\t"$11,$12,$13,$14}' |sort -gr|head -$1; }
dos2unix() { tr -d '\r'; }
#Draw ascii box around $1
box() { t="LL$1RR";c=${2:-#}; echo ${t//?/$c}; echo "$c $1 $c"; echo ${t//?/$c};} #From bartonski

#copy to RAM
bi () {	cp -a $1 /dev/shm; cd /dev/shm/$1; 	here=`pwd`;	echo you are here $here; }

#remove stuff from bash command history
forget() { H=$HOME/.bash_history;G=$(grep $1 $H|wc -l); sed '/'$1'/d' $H|sponge $H ; echo "Found and removed $G occurences of $1"; }

#print nth line of stdin (ls -l|nth 3)
nth(){(for ((x=0;x<=$1;x++)) ; do read -r; done ; echo "$REPLY")}

#Get author and title from most epub-books
epubtitle() { unzip -p "$1" *.opf|xmlstarlet sel  -N "dc=http://purl.org/dc/elements/1.1/" -N "opf=http://www.idpf.org/2007/opf" -t -v '////dc:creator/@opf:file-as[contains(@opf:role,'aut')]' -o ' - ' -v '////dc:title' -n 2>/dev/null; }

# important exports
export BROWSER=/usr/bin/firefox 
export EDITOR=vim
export PAGER=less

# make there commands run in background automatically
function soffice() { command soffice "$@" & }
function firefox() { command firefox "$@" & }
function xpdf() { command xpdf "$@" & }
function vlc() { command vlc "$@" & }
function gvim() { command gvim "$@" & }
function thunar() { command thunar "$@" & }
function mecp () { scp "$@" ${SSH_CLIENT%% *}:Desktop/; }

# run local bashrc that might exist
if [[ -f ~/.bashrc-"$HOSTNAME" ]]; then
. ~/.bashrc-"$HOSTNAME"
fi

export PATH=$PATH:"/home/users/micke/.gem/ruby/2.0.0/bin:/home/users/micke/sh"
export LIBLG_DRVIVERS_PATH=/usr/lib/vdpau:/usr/lib/xorg/modules/dri
