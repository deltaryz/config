#!/bin/sh

# FLAGS:
# -y         skips confirmation prompt
# --nogit    don't mess with git's config

# init
clear
echo "-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --"
echo ">> Shell script for automated system configuration"
echo "@deltaryz       https://github.com/deltaryz/config"
echo "-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --"
echo ""
echo "This script must be executed from the repo's root." # TODO: detect this automatically
echo ""
echo "* WARNING:"
echo "This  script  will replace existing  dotfiles  and"
echo "install new software on your system.  It will also"
echo "set Git credentials and settings."
echo ""

# check if we used -y flag
if [ "$1" != "-y" ] && [ "$2" != "-y" ]; then
    # flag not passed, make user confirm
    echo "* (Use -y to skip this prompt)"
    echo "Please confirm this potentially destructive action"
    echo ""

    while true; do
        read -p "[y/N] > " yn
        case $yn in
            [Yy]* ) break;;
            * ) exit;; # cancel script
        esac
    done
fi

echo ""
echo "-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --"
echo ">>             Now starting setup!!             <<"
echo "-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --"
echo ""

# detect what distro we're running on
distrostring=$(cat /etc/issue)

case $distrostring in

    # Alpine
    *"Alpine"* )
        distrogeneric="alpine"
        distro="alpine"
        ;;

    # Debian
    *"Debian"* )
        distrogeneric="debian"
        distro="debian"
        ;;

    # Ubuntu
    *"Ubuntu"* )
        distrogeneric="debian"
        distro="alpine"
        ;;

    # Arch
    *"Arch"* )
        distrogeneric="arch"
        distro="arch"
        ;;

    # Manjaro
    *"Manjaro"* )
        distrogeneric="arch"
        distro="manjaro"
        ;;

    # Unknown / Other
    * )
        distrogeneric="unknown"
        distro="unknown"
        ;;

esac

currentuser=$(whoami)

echo "User:              $currentuser"
echo "Distro:            $distro"
echo "Generic Distro:    $distrogeneric"
echo ""

echo "Adding $currentuser to sudoers..."
sudo grep -v "$currentuser" /etc/sudoers > ./tempsudoers
echo "$currentuser ALL=(ALL:ALL) NOPASSWD:ALL" | tee -a ./tempsudoers
sudo chown root ./tempsudoers
sudo mv ./tempsudoers /etc/sudoers

echo ""
echo "* CONFIGURING PACKAGES"
echo ""


case $distrogeneric in

    "alpine" )
        
        ;;

    "debian" )

        ;;

    "arch" )

        ;;

    * )
        echo "! ! ! - WARNING - ! ! !"
        echo "This distro was not recognized."
        echo "No packages will be installed."
        ;;

esac

echo ""
echo "* CONFIGURING DOTFILES"
echo ""

# set file paths
dotprofile=$(realpath ./dotprofile)
dotconfig=$(realpath ./dotconfig/)
dotvimrc=$(realpath ./dotvimc)
dottmuxconf=$(realpath ./dottmux.conf)
dottmux=$(realpath ./dottmux.tgz)

echo "Symlinking ~/.config..."
rm -rf ~/.config-old
mv ~/.config ~/.config-old
ln -s $dotconfig ~/.config

echo "Symlinking ~/.vimrc..."
rm ~/.vimrc-old
mv ~/.vimrc ~/.vimrc-old
ln -s $dotvimrc ~/.vimrc

echo "Symlinking ~/.tmux.conf..."
rm ~/.tmux.conf-old
mv ~/.tmux.conf ~/.tmux.conf-old
ln -s $dottmuxconf ~/.tmux.conf

# this crap is messy lmao
echo "Extracting ~/.tmux..."
rm -rf ~/.tmux-old
mv ~/.tmux ~/.tmux-old
mkdir ~/.tmux
tar zxf $dottmux -C ~/.tmux/ 
mv ~/.tmux/home/delta/.tmux/* ~/.tmux/
rm -rf ~/.tmux/home

echo ""
echo "* CONFIGURING GIT"

if [ "$1" != "--nogit" ] && [ "$2" != "--nogit" ] ; then
    git config --global credential.helper store
    git config --global user.name "deltaryz"
    git config --global user.email "wincam97@gmail.com"
    git config --global pull.rebase true
else
    echo "(User passed --nogit flag, not touching git...)"
fi

echo ""
echo "-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --"
echo ">>     >>    ♥    Script is done    ♥    <<     <<"
echo "-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --"
echo ""

# TODO: Ask user to input what network interface to insert into getip (perhaps show an ifconfig output?)
# TODO: Automatically install relevant packages & intelligently use the correct package manager/etc depending on the distro the script is running on
# TODO: set an envvar when the script has completed successfully to prevent running it again
# TODO: Show environment variables used for per-system configuration after the script runs (also show them again if the script has already run)


