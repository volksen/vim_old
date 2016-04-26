# vim
vim config files


## add a new module
git submodule add http://github.com/tpope/vim-fugitive.git bundle/fugitive

## checkout on new machine
cd ~
git clone http://github.com/username/dotvim.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc
cd ~/.vim
git submodule update --init

## Upgrading a plugin bundle
cd ~/.vim/bundle/fugitive
git pull origin master

## Upgrading all bundled plugins    
git submodule foreach git pull origin master

