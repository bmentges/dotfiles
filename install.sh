# !/usr/bin/env bash
# Installation script for my dotfiles
# @author Bruno Mentges de Carvalho

# Directory where this script is in
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

install_bash_dotfiles() {
    echo
    echo -e "\tInstalling bash aliases"
    echo -e "\t\tExecuting: ln -sf $DIR/.bashrc ~/.bashrc"
    ln -sf $DIR/.bashrc ~/.bashrc
    echo -e "\t\tExecuting: ln -sf $DIR/.bash_aliases ~/.bash_aliases"
    ln -sf $DIR/.bash_aliases ~/.bash_aliases
    echo -e "\t\tExecuting: ln -sf $DIR/git-completion.bash ~/git-completion.bash"
    ln -sf $DIR/git-completion.bash ~/git-completion.bash
    echo -e "\t\tExecuting: ln -sf $DIR/.bash_profile ~/.bash_profile"
    ln -sf $DIR/.bash_profile ~/.bash_profile
    echo -e "\tAll bash aliases successfully installed"
    echo
}

install_vim_dotfiles() {
    echo
    echo -e "\tInstalling vim aliases"
    echo -e "\t\tExecuting: ln -sf $DIR/vim/.vimrc ~/.vimrc"
    ln -sf $DIR/vim/.vimrc ~/.vimrc
    echo -e "\t\tExecuting: ln -sf $DIR/vim/.vim ~/.vim"

    if [ -e ~/.vim ]
    then
        rm -rf ~/.vim
    fi

    ln -sf $DIR/vim/.vim ~/.vim
    echo -e "\tAll vim aliases successfully installed"
    echo
}

install() {
    echo "Installing..."
    install_bash_dotfiles
    install_vim_dotfiles

} 

dont_install() {
    echo "NOT installing... exiting..."
}



echo
echo "Installing dotfiles into your home directory."
echo "This installation will forcibly create the following symlinks:"
echo
echo -e "\t# Bash aliases"
echo -e "\t~/.bashrc"
echo -e "\t~/.bash_aliases"
echo -e "\t~/git-completion.bash"
echo
echo -e "\t# Vim aliases"
echo -e "\t~/.vimrc"
echo -e "\t~/.vim"
echo 
echo "It will remove any existing files in these locations"
echo "Do you want to continue [Y/n]:"
read answer

case $answer in
    y)
        install
        ;;
    n) 
        dont_install
        ;;
    *) 
        install
        ;;
esac





