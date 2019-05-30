# Adapted from https://superuser.com/a/1412976
CPYTHON="$HOME/Documents/cpython"
PREFIX="/usr/local"
REQUIRED="zlib1g-dev libffi-dev libssl-dev"
OPTIONAL="libbz2-dev libncursesw5-dev libgdbm-dev liblzma-dev libsqlite3-dev tk-dev uuid-dev libreadline-dev"

# https://github.com/pyenv/pyenv/wiki/Common-build-problems
ALL="make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git"

if [ $# -ne 1 ]; then
    echo "Usage: $0 <python version number>" >&2
    exit 1
fi

sudo apt install $ALL

if [ ! -d "$CPYTHON" ]; then
    git clone git@github.com:python/cpython.git
fi

cd "$CPYTHON"
git checkout master
git pull
git checkout v$1 || exit $?
./configure --enable-optimizations --prefix="$PREFIX"
make -j$(nproc)
sudo make install
