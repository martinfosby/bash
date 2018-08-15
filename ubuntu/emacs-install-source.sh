#!/bin/bash

if [ ! -d "/usr/src/emacs-25.3" ]
then
    pushd /usr/src/
    sudo wget --verbose http://ftp.snt.utwente.nl/pub/software/gnu/emacs/emacs-25.3.tar.gz /usr/src
    sudo tar -xvf emacs-25.3.tar.gz
    rm emacs-25.3.tar.gz
    cd emacs-25.3
    sudo ./configure
    sudo make && sudo make install
    popd
fi
