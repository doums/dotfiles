#
# ~/.bashrc
#

#If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH=$PATH:/opt/node/bin/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

alias ..='cd ..'
alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias sb='subl'
alias emu="cd /home/pierre/Android/Sdk/emulator/ && emulator -avd android -gpu host -accel on -scale 2 -no-boot-anim"

# http://tldp.org/HOWTO/Xterm-Title-4.html#ss4.3
# https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
PROMPT_COMMAND='echo -ne "\033]0;${SHELL##*/} ${PWD}\007"'
PS1='\u \[\033[0;32m\]\$ \[\033[m\]'

export QT_AUTO_SCREEN_SCALE_FACTOR=1
export GDK_SCALE=2
export GDK_DPI_SCALE=0.5

