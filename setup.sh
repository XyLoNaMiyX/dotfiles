rm -f ~/.bashrc
ln ./bashrc ~/.bashrc

git config --global core.excludesfile "$(pwd)/gitignore"

rm -f ~/.config/nvim/init.vim
mkdir -p ~/.config/nvim
ln ./init.vim ~/.config/nvim/

rm -f ~/.XCompose
ln ./XCompose ~/.XCompose
