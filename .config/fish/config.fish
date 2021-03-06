if test -n "$DESKTOP_SESSION"
    set -x (gnome-keyring-daemon --start | string split "=")
end

alias ls='exa --group-directories-first'
alias la='exa -lag --group-directories-first'
alias db='adb shell input keyevent 82'
alias dbk='adb shell am force-stop com.monbuilding.app'
alias rr='adb shell input text "RR"'
alias ds='xrandr --output eDP-1 --auto --output DP-2 --auto --scale 1.333 --right-of eDP-1'
alias fk='fk.sh'
alias fkp='fkp.sh'
alias pac='pac.sh'
alias hok='hock.sh'
alias vim='nvim'
alias gl='gl.sh'
alias glf='git log -p --date=format:%c --abbrev-commit --'
alias wtr='curl fr.wttr.in'
alias dc='docker-compose'
alias log='docker logs -f'

set fish_greeting
set -x LD_LIBRARY_PATH /usr/local/lib $LD_LIBRARY_PATH
set -x QT_AUTO_SCREEN_SCALE_FACTOR 1
set -x EDITOR /usr/bin/nvim
set -x VISUAL /usr/bin/nvim
set -x GDK_SCALE 2
set -x GDK_DPI_SCALE 0.5
set -x ANDROID_HOME $HOME/Android/Sdk
set -x PATH $ANDROID_HOME/emulator $PATH
set -x PATH $ANDROID_HOME/tools $PATH
set -x PATH $ANDROID_HOME/tools/bin $PATH
set -x PATH $ANDROID_HOME/platform-tools $PATH
set -x JAVA_HOME /usr/lib/jvm/default
set -x XDG_SESSION_TYPE X11
set -x PATH $PATH $HOME/.cargo/bin
set -x PATH $PATH $HOME/.gem/ruby/2.7.0/bin
set -x fish_emoji_width 2
set -x PATH /opt/node/bin $PATH
set -x PATH /home/pierre/.yarn/bin $PATH
set -x PATH $HOME/.local/bin $PATH
set -x PATH $HOME/.local/jetbrains $PATH
set -x PATH $PATH $HOME/.local/share/JetBrains/Toolbox/bin
set -x MANPAGER 'nvim +Man!'
set -x MAKEFLAGS '-j8'
set -x FZF_DEFAULT_OPTS "--bind 'ctrl-w:toggle-preview-wrap,ctrl-p:toggle-preview,ctrl-a:toggle-all' --color='bg:#2b2b2b,fg:#e6e1dc,preview-bg:#2b2b2b,preview-fg:#e6e1dc,border:#4d4d4d,bg+:#333435,fg+:#e6e1dc,hl:#cc7833,hl+:#cc7833,gutter:#2b2b2b,pointer:#cc7833,prompt:#bc9458,marker:#8a653b,spinner:#8a653b,header:#bc9458,info:#8a653b'"
set -x FZF_DEFAULT_COMMAND "fd -HI -t f"
set -x XDG_DATA_DIRS /home/pierre/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share
set -x NNN_OPTS QAex
set -x NNN_COLORS 2341
set -x NNN_PLUG 't:-_bat $nnn;f:-_|firefox $nnn*'
set -x NNN_BMS 'h:~;d:~/Documents;r:/;a:~/Documents/aos/aos-app/'
set -x NNN_FCOLORS '0505040a00060e0801030301'
set -x XDG_CONFIG_HOME $HOME/.config
set -x DENO_INSTALL $HOME/.deno
set -x PATH $PATH $DENO_INSTALL/bin
