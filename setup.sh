#!/bin/bash
# Script Name: Lykegenes VPS Toolkit
# Author: Patrick Samson
# License: MIT License (refer to README.md for more details)
#

# DO NOT EDIT ANYTHING UNLESS YOU KNOW WHAT YOU ARE DOING.
YELLOW='\e[93m'
RED='\e[91m'
ENDCOLOR='\033[0m'
CYAN='\e[96m'
GREEN='\e[92m'
SCRIPTPATH=$(pwd)

sudo chmod -R 775 * >/dev/null 2>&1

function pause(){
   read -p "$*"
}

if [ "$EUID" -ne 0 ]
  then
  echo
  echo -e $RED'Please run as root using the command: '$ENDCOLOR'sudo ./setup.sh'
  echo
  exit 0
fi

clear
echo
echo -e $RED
echo -e "_    _   _ _  _ ____ ____ ____ _  _ ____ ____"
echo -e "|     \_/  |_/  |___ | __ |___ |\ | |___ [__ "
echo -e "|___   |   | \_ |___ |__] |___ | \| |___ ___]"
echo -e $CYAN
echo -e " __     ______  ____    _____           _ _    _ _   "
echo -e " \ \   / /  _ \/ ___|  |_   _|__   ___ | | | _(_) |_ "
echo -e "  \ \ / /| |_) \___ \    | |/ _ \ / _ \| | |/ / | __|"
echo -e "   \ V / |  __/ ___) |   | | (_) | (_) | |   <| | |_ "
echo -e "    \_/  |_|   |____/    |_|\___/ \___/|_|_|\_\_|\__|"
echo
echo -e $GREEN'Lykegenes '$SOFTNAME' Installer Script'$ENDCOLOR
echo
echo -e 'NOTE: At this point, this script has been confirmed to work only on Ubuntu variants.'
echo
echo -e $YELLOW'00. '$ENDCOLOR'Check and Update Lykegenes VPS ToolKit'
echo -e $YELLOW'01. '$ENDCOLOR'Optimize server'
echo -e $YELLOW'02. '$ENDCOLOR'Install the Base Tool and Utilities'
echo -e $YELLOW'03. '$ENDCOLOR'Configure a new User'
echo -e $YELLOW'10. '$ENDCOLOR'Nginx - Install'
echo -e $YELLOW'11. '$ENDCOLOR'Nginx - Uninstall'
echo -e $YELLOW'20. '$ENDCOLOR'PostgreSQL - Install'
echo -e $YELLOW'21. '$ENDCOLOR'PostgreSQL - Uninstall'
echo -e $YELLOW'30. '$ENDCOLOR'PHP - Install'
echo -e $YELLOW'31. '$ENDCOLOR'PHP - Uninstall'
echo -e $YELLOW'32. '$ENDCOLOR'HHVM - Install'
echo -e $YELLOW'33. '$ENDCOLOR'HHVM - Uninstall'
echo -e $YELLOW'34. '$ENDCOLOR'Composer - Install'
echo -e $YELLOW'35. '$ENDCOLOR'Composer - Uninstall'
echo -e $YELLOW'80. '$ENDCOLOR'Transmission Web UI - Install'
echo -e $YELLOW'81. '$ENDCOLOR'Transmission Web UI - Uninstall'
echo -e $YELLOW'99. '$ENDCOLOR'Exit'

echo
echo -n "What would you like to do? [00-99]: "
read option
case $option in
    0 | 00)
        echo
        echo -e $YELLOW'--->Checking for updates...'$ENDCOLOR
        git fetch origin master
        git reset --hard FETCH_HEAD
        git clean -df
        echo
        pause 'Press [Enter] to restart and continue...'
        cd $SCRIPTPATH
        sudo ./setup.sh
        exit 0
        ;;
    1 | 01)
        sudo ./optimize-server.sh
        ;;
    2 | 02)
        sudo ./utilities/base-tools-installer.sh
        ;;
    10)
        sudo ./webservers/nginx-installer.sh
        ;;
    11)
        sudo ./webservers/nginx-uninstaller.sh
        ;;
    20)
        sudo ./databases/pgsql-installer.sh
        ;;
    21)
        sudo ./databases/pgsql-uninstaller.sh
        ;;
    30)
        sudo ./php/php-installer.sh
        ;;
    31)
        sudo ./php/php-uninstaller.sh
        ;;
    32)
        sudo ./php/hhvm-installer.sh
        ;;
    33)
        sudo ./php/hhvm-uninstaller.sh
        ;;
    34)
        sudo ./php/composer-installer.sh
        ;;
    35)
        sudo ./php/composer-uninstaller.sh
        ;;
    80)
        sudo ./utilities/transmission-webui-installer.sh
        ;;
    81)
        sudo ./utilities/transmission-webui-uninstaller.sh
        ;;
    99)
        echo 'Exiting...'
        echo
        echo -e $YELLOW'Thank you for using the Lykegenes VPS ToolKit!'$ENDCOLOR
        echo
        sleep 2
        ;;
    *)
        echo -e $RED'Invalid Option'$ENDCOLOR
        ScriptLoc=$(readlink -f "$0")
        sleep 1
        exec $ScriptLoc

esac