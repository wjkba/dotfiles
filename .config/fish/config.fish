if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting ""

alias zj='zellij'

zoxide init fish | source

set -x EDGE_PATH "/usr/bin/ungoogled-chromium"
set -x ANDROID_HOME $HOME/Android/Sdk
set -x PATH $ANDROID_HOME/emulator $ANDROID_HOME/tools $ANDROID_HOME/tools/bin $ANDROID_HOME/platform-tools $PATH

