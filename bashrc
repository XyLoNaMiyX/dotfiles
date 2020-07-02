# Source this for handy stuff
export APPS_DIR=~/Apps/bin

PATH="$APPS_DIR"\
":~/.cargo/bin"\
":~/.local/bin"\
":~/.texlive/2019/bin/x86_64-linux"\
":$PATH"

export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/jre"

alias pipu="pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"

# Needs 'dig' installed (pkgfile -s dig -> bind-tools on Arch)
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"

VISUAL="nano"
rmempty(){ find $@ -type d -empty -delete; }
changelog() { git log --oneline $@..HEAD | tac | less; }

alias gdb='gdb -q'  # stackoverflow.com/a/40074187/4759433

csnip(){ gcc -Ofast      $@ -o /tmp/csnip &&     /tmp/csnip < /dev/stdin ; rm -f /tmp/csnip; }
asm32(){ gcc -m32        $@ -o /tmp/asm32 &&     /tmp/asm32 < /dev/stdin ; rm -f /tmp/asm32; }
intel(){ gcc -masm=intel $@ -o /tmp/intel &&     /tmp/intel < /dev/stdin ; rm -f /tmp/intel; }
debug(){ gcc -gstabs+    $@ -o /tmp/debug && gdb /tmp/debug < /dev/stdin ; rm -f /tmp/debug; }

vidcut(){ ffmpeg -ss 00:$2 -i $1 -to 00:$3 -c copy output.mp4; }

alias telethon="python3 -i ~/dotfiles/tl.py"
alias gif2mp4="ffmpeg -i -vf format=yuv420p"
alias copy="xclip -selection clipboard"
alias paste="xclip -selection clipboard -out"

alias rainbow=~/dotfiles/rainbow

function getBranch { git rev-parse --abbrev-ref HEAD 2> /dev/null; }
function getPrompt { echo -e "\033[1;32m┌┤ $USER $(getBranch) $(rainbow $(pwd))\033[0m\n└─"; }
PS1='$(getPrompt) '

alias bench=hyperfine
alias python="python3"
alias pipi="pip3 install --user"
alias pipr="pip3 uninstall"
alias music="mpv --no-video --shuffle"
alias term="xfce4-terminal"
alias catjson="jq ''"

# desktop files for the whiskers' menu go in ~/.local/share/applications/

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

source ~/dotfiles/.pybashrc
