# Mickes .bashrc
# Updated on mån okt 14 22:29:08 CEST 2019

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Append to the history file, don't overwrite it
shopt -s histappend
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=2000

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

color_prompt=yes
force_color_prompt=yes

# Trim dirs to 3
PROMPT_DIRTRIM=2

# Alias definitions in separate file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

PS1='\[\033[01;3;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

# Make less show contents of directories instead of complain
export LESSOPEN='|dir=%s;test -d "$dir" && ls -lah --color "$dir"'

# Important exports
export BROWSER=/usr/bin/firefox 
export EDITOR=vim
export PAGER=less
export IGNOREEOF=3
#export TERM=xterm-256color # To avoid termcap problem
alias ssh='TERM=xterm-256color ssh'

# > Can't overwrite ( >| overrides )
set -o noclobber

# Completion
shopt -s cdspell cdable_vars
shopt -s direxpand dirspell
shopt -s progcomp_alias

# Don't quit with running jobs
shopt -s checkjobs

# Set up default XDG directories
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# XDG fixes
export ATOM_HOME="$XDG_DATA_HOME"/atom
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export ELINKS_CONFDIR="$XDG_CONFIG_HOME"/elinks
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export LESSHISTFILE="$XDG_CACHE_HOME"/lesshst
export SCREENRC="$XDG_CONFIG_HOME"/screen/screenrc
export MPLAYER_HOME="$XDG_CONFIG_HOME"/mplayer
export _Z_DATA=$XDG_CACHE_HOME/z/cache
#export GNUPGHOME="$XDG_CONFIG_HOME"/gnupg

# Use the existing GPG sockets for ssh
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"

# Includes user's bin directories in PATH
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Open new terms in current working directory
[[ -r "/etc/profile.d/vte.sh" ]] && source /etc/profile.d/vte.sh

# Use z frequency jumper (needs to be after vte)
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

# Add colors to less when displaying manpages
export LESS_TERMCAP_md=$'\e[1;35m' # begin bold - syntax and keywords
export LESS_TERMCAP_me=$'\e[0m' # end mode - some rows
export LESS_TERMCAP_so=$'\e[0;43;30m' # begin standout-mode -- statusbar and searchhighlights
export LESS_TERMCAP_se=$'\e[0m' # end standout-mode first and last row background
export LESS_TERMCAP_us=$'\e[0;32m' # begin underline "variables"
export LESS_TERMCAP_ue=$'\e[0m'    # end underline background

export BAT_THEME="Monokai Extended Origin"

export GPG_TTY=$(tty)

# Prevent GTK accessibility stuff from running
export NO_AT_BRIDGE=1
