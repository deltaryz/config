#!/bin/sh

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
# TODO: --nopersonal flag for something more friendly to people who aren't delta
echo ""
echo "Please confirm this potentially destructive action"
echo ""

# make user confirm
while true; do
    read -p "Y/N > " yn
    case $yn in
        [Yy]* ) break;;
        * ) exit;; # cancel script
    esac
done

# TODO: Ask user to input what network interface to insert into getip (perhaps show an ifconfig output?)
# TODO: Automatically install relevant packages & intelligently use the correct package manager/etc depending on the distro the script is running on
# TODO: symlink from git repo instead of copying
# TODO: set an envvar when the script has completed successfully to prevent running it again
# TODO: Show environment variables used for per-system configuration after the script runs (also show them again if the script has already run)


