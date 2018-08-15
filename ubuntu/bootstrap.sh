#!/bin/bash

# Enable sources, add PPAs and update sources: 
# sudo sed 's/# deb/deb/' -i /etc/apt/sources.list

# sudo add-apt-repository ppa:tiheum/equinox
# sudo add-apt-repository ppa:am-monkeyd/nautilus-elementary-ppa
#sudo add-apt-repository -y ppa:ubuntu-elisp # for emacs
sudo apt-get update
sudo apt-get upgrade

if [ -f /usr/bin/dropbox ]; then
    # Symlinking home folders.
    mv ~/.emacs.d ~/.emacs.d.old
    ln -s ~/Dropbox/.emacs.d/ ~/

    sudo mv ~/.profile ~/.profile.old
    ln  ~/Dropbox/.profile ~/
    source ~/.profile

    sudo mv ~/.bashrc ~/.bashrc.old
    ln  ~/Dropbox/.bashrc ~/
    source ~/.bashrc

    sudo mv ~/.vimrc ~/.vimrc.old
    ln  ~/Dropbox/.vimrc ~/

    ln -s ~/Dropbox/org ~/
    ln -s ~/Dropbox/programming ~/
    ln -s ~/Dropbox/spacemacs ~/
    ln -s ~/Dropbox/TODO/ ~/
    ln -s ~/Dropbox/bash-scripts/ ~/
    ln -s ~/Dropbox/powershell ~/
    ln -s ~/Dropbox/bin ~/
    ln -s ~/Dropbox/bash ~/
    ln -s ~/Dropbox/c ~/
    ln -s ~/Dropbox/c++ ~/
    ln -s ~/Dropbox/python ~/
    ln -s ~/Dropbox/k\&r ~/
fi



# restart nautilus (req. to activate elementary):
nautilus -q

# remove lock screen

# gsettings set org.gnome.desktop.screensaver lock-enabled false

# Altering settings power management (OLD method):

# gconftool-2 --set --t# ype string /apps/gnome-power-manager/critical_battery       shutdown 
# gconftool-2 --set --type bool   /apps/gnome-power-manager/battery_reduce         false
# gconftool-2 --set --type bool   /apps/gnome-power-manager/idle_dim_battery       false
# gconftool-2 --set --type string /apps/gnome-power-manager/lid_ac                 blank
# gconftool-2 --set --type string /apps/gnome-power-manager/lid_battery            blank
# gconftool-2 --set --type string /apps/gnome-power-manager/sleep_computer_ac      0
# gconftool-2 --set --type string /apps/gnome-power-manager/sleep_computer_battery 0
# gconftool-2 --set --type string /apps/gnome-power-manager/power                  interactive
