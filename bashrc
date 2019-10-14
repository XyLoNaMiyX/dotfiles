# Source this for handy stuff
export APPS_DIR=~/Apps/bin

PATH="$APPS_DIR"\
":~/.cargo/bin"\
":~/.local/bin"\
":$PATH"

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

alias telethon="python3 -i ~/dotfiles/tl.py"
alias gif2mp4="ffmpeg -i -vf format=yuv420p"
alias copy="xclip -selection clipboard"
alias paste="xclip -selection clipboard -out"

alias rainbow=~/dotfiles/rainbow

function getBranch { printf '@'; git status 2> /dev/null | head -n1 | sed 's/On branch //'; }
function getPrompt { echo -e "\033[1;32m┌┤ $USER $(getBranch) $(rainbow $(pwd))\033[0m\n└─"; }
PS1='$(getPrompt) '

alias bench=hyperfine
alias python="python3"
alias pipi="pip3 install --user"
alias pipr="pip3 uninstall"
alias music="mpv --no-video --shuffle"
alias term="xfce4-terminal"

# desktop files for the whiskers' menu go in ~/.local/share/applications/

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

. ~/.nix-profile/etc/profile.d/nix.sh
