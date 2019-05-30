rm -f ~/.bashrc
ln ./bashrc ~/.bashrc

g++ -orainbow -std=c++17 rainbow.cpp

git config --global core.excludesfile "$(pwd)/gitignore"

rm -f ~/.config/nvim/init.vim
mkdir -p ~/.config/nvim
ln ./init.vim ~/.config/nvim/

rm -f ~/.XCompose
ln ./XCompose ~/.XCompose

mkdir -p $APPS_DIR
cd $APPS_DIR
if [ ! -f mc ]; then
    wget https://raw.githubusercontent.com/LonamiWebs/Py-Utils/master/mineutils/mc
    chmod +x mc
fi

