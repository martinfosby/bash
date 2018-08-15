#!/bin/bash

# Enable sources, add PPAs and update sources: 
# sudo sed 's/# deb/deb/' -i /etc/apt/sources.list

# sudo add-apt-repository ppa:tiheum/equinox
# sudo add-apt-repository ppa:am-monkeyd/nautilus-elementary-ppa
#sudo add-apt-repository -y ppa:ubuntu-elisp # for emacs

printf '\e[1;34m%-6s\e[m' "build emacs, python from source? Y/n: "
read build_source
if [ "$build_source" -eq 'y' ] || [ "$build_source" -eq 'Y' ] || [ "$build_source" -eq "yes" ] || [ "$build_source" -eq "Yes" ]
then
    # install emacs from source
    if [ ! -d "/usr/src/emacs-25.3" ]
    then
        # required for emacs to configure
        sudo apt-get install -y build-essential texinfo libx11-dev libxpm-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev libgtk2.0-dev libncurses-dev
        printf '\e[1;34m%-6s\e[m' "installing emacs-25.3 from source please wait..."
        pushd /usr/src/
        sudo wget --verbose http://ftp.snt.utwente.nl/pub/software/gnu/emacs/emacs-25.3.tar.gz /usr/src
        sudo tar -xvf emacs-25.3.tar.gz
        rm emacs-25.3.tar.gz
        cd emacs-25.3
        sudo ./configure
        sudo make && sudo make install
        popd
    fi

    # install python from source
    if [ ! -d "/usr/src/Python-3.6.5" ]
    then
        printf '\e[1;34m%-6s\e[m' "installing python-3.6.5 from source please wait..."
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
fi




sudo apt-get update
sudo apt-get upgrade

# Symlinking home folders.
cd ~/
# check if emacs dir exists
if [ -d "~/.emacs.d" ]
then
    mv ~/.emacs.d ~/.emacs.d.old
    ln -s ~/Dropbox/.emacs.d/ ~/
else
    ln -s ~/Dropbox/.emacs.d/ ~/
fi

if [ -f "~/.profile" ]
then
    mv ~/.profile ~/.profile.old
    ln  ~/Dropbox/.profile ~/
else
    ln ~/Dropbox/.profile ~/
fi

if [ -f "~/.vimrc" ]
then
    mv ~/.vimrc ~/.vimrc.old
    ln  ~/Dropbox/.vimrc ~/
else
    ln  ~/Dropbox/.vimrc ~/
fi

ln -s ~/Dropbox/org ~/
ln -s ~/Dropbox/programming ~/
ln -s ~/Dropbox/spacemacs ~/
ln -s ~/Dropbox/TODO/ ~/
ln -s ~/Dropbox/bash-scripts/ ~/
ln -s ~/Dropbox/powershell ~/

# Adding software:
sudo apt-get install -y dconf-tools vim

sudo apt-get install -y python-pip virtualenv

# pip
pip install nikola

# c, c++, java
sudo apt-get install -y global

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
dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:swapescape','ctrl:swap_lalt_lctl_lwin']"
#!/bin/bash

sudo add-apt-repository -y ppa:webupd8team/java # java

sudo apt-get update


# java
# You must accept the Oracle Binary Code License
# http://www.oracle.com/technetwork/java/javase/terms/license/index.html
# usage: get_jdk.sh <jdk_version> <ext>
# jdk_version: 8(default) or 9
# ext: rpm or tar.gz

jdk_version=${1:-8}
ext=${2:-rpm}

readonly url="http://www.oracle.com"
readonly jdk_download_url1="$url/technetwork/java/javase/downloads/index.html"
readonly jdk_download_url2=$(
    curl -s $jdk_download_url1 | \
        egrep -o "\/technetwork\/java/\javase\/downloads\/jdk${jdk_version}-downloads-.+?\.html" | \
        head -1 | \
        cut -d '"' -f 1
         )
[[ -z "$jdk_download_url2" ]] && echo "Could not get jdk download url - $jdk_download_url1" >> /dev/stderr

readonly jdk_download_url3="${url}${jdk_download_url2}"
readonly jdk_download_url4=$(
    curl -s $jdk_download_url3 | \
        egrep -o "http\:\/\/download.oracle\.com\/otn-pub\/java\/jdk\/[8-9](u[0-9]+|\+).*\/jdk-${jdk_version}.*(-|_)linux-(x64|x64_bin).$ext"
         )

for dl_url in ${jdk_download_url4[@]}; do
    wget --no-cookies \
         --no-check-certificate \
         --header "Cookie: oraclelicense=accept-securebackup-cookie" \
         -N $dl_url
done
# java done

# mono
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb http://download.mono-project.com/repo/ubuntu xenial main" | sudo tee /etc/apt/sources.list.d/mono-official.list
sudo apt-get update
# mono done

# Adding software:
sudo apt-get install -y dconf-tools vim git curl cmake mono-complete
# Python
sudo apt-get install -y python-pip virtualenv exuberant-ctags python-pygments 

# pip
#pip install nikola

# android sdk
if [ ! -d "~/sdk" ]
   pushd ~/
   mkdir sdk && cd sdk 
   sudo wget --verbose https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip
   sudo unzip sdk-tools-linux*.zip
   cd tools
   ### source codes

   # install global from source code
   if [ ! -d "/usr/src/global-6.6.1" ]
   then
       pushd /usr/src/
       sudo wget https://fhttps://dl.google.com/android/repository/sdk-tools-linux-3859397.ziptp.gnu.org/pub/gnu/global/global-6.6.1.tar.gz
       sudo tar -xvf global-6.6.1.tar.gz
       cd global-6.6.1
       sudo ./configure --with-exuberant-ctags=/usr/bin/ctags
       sudo make
       sudo make install
       popd
   fi

   # required for emacs to configure
   sudo apt-get install build-essential texinfo libx11-dev libxpm-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev libgtk2.0-dev libncurses-dev

   ## installing from source
   # emacs
   if [ ! -d "/usr/src/emacs-25.3" ]
   then
       printf '\e[1;34m%-6s\e[m' "installing emacs from source please wait..."
       pushd /usr/src/
       sudo wget --verbose http://ftp.snt.utwente.nl/pub/software/gnu/emacs/emacs-25.3.tar.gz /usr/src
       sudo tar -xvf emacs-25.3.tar.gz
       cd emacs-25.3
       sudo ./configure
       sudo make && sudo make install
       popd
       printf '\e[1;34m%-6s\e[m' "all done"
   fi

