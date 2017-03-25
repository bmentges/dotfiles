# Basic development
sudo apt-get install -y vim git tmux i3
mkdir -p ~/projetos
cd ~/projetos
if [ ! -d "config" ]; then
  git clone https://github.com/bmentges/dotfiles.git
fi
mv ~/.bashrc ~/.bashrc.old
ln -s ~/dev/config/bashrc ~/.bashrc
ln -s ~/dev/config/vimrc ~/.vimrc
ln -s ~/dev/config/gitconfig ~/.gitconfig
ln -s ~/dev/config/git_template/ ~/.git_template/
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qa

# Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
sudo apt-get update
sudo apt-get install -y google-chrome-stable

# RbEnv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
source ~/.bashrc
sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev
rbenv install 2.3.1
rbenv local 2.3.1

# Others
sudo apt-get install -y htop inotify-tools tree curl
