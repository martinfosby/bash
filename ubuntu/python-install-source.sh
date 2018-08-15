#!/bin/bash




# install python from source
if [ ! -d "/usr/src/Python-3.6.5" ]
then
    sudo apt-get build-dep python2.7
    pushd /usr/src/
    sudo wget --verbose https://www.python.org/ftp/python/3.6.5/Python-3.6.5.tar.xz
    sudo tar -xvf Python-3.6.5.tar.xz
    sudo rm Python-3.6.5.tar.xz
    cd Python-3.6.5
    sudo ./configure
    sudo make && sudo make install
    popd
fi
