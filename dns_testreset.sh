#!/bin/bash

# Refer to below URL for more information.
# https://askubuntu.com/questions/1705/how-can-i-create-a-select-menu-in-a-shell-script
# Thank you to Dennis Williamson for all the good information.

#########################################
#   					#
#    DNS Resolve Time/DNS-Cache Reset   #
#					#
#########################################
#               by XCR0061		#
#########################################

set -o errexit
#set -o xtrace

clear
tput setaf 208
echo "  ##################################### "
echo "  #   ____  ______________________    # "
echo "  #   \   \/  /\_   ___ \______   \   # "
echo "  #    \     / /    \  \/|       _/   # "
echo "  #    /     \ \     \___|    |   \   # "
echo "  #   /___/\  \ \______  /____|_  /   # "
echo "  #         \_/        \/       \/    # "
echo "  ##################################### "
echo "       DNS Resolve Time/Cache-Flush     "
echo ""
tput sgr0

PS3="$(tput setaf 111) $(tput bold)Please Select your Choice: $(tput sgr0) "
options=("Test DNS Response time" "Local DNS-Cache Size" "Flush Local DNS-Cache" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Test DNS Response time")
		tput setaf 222
		echo -e "$(tput bold) $(tput smul)\nDNS Response Time Test...$(tput rmul)"
		echo ""
		read -p "Please enter DNS IPv4 Address: " dns
		echo ""
		time dig @$dns | grep 'Query time'
		tput sgr0
		echo ""
            ;;
        "Local DNS-Cache Size")
        	tput setaf 222
		echo -e "$(tput bold) $(tput smul)\nLocal DNS Cache size:  $(tput rmul)"    
		echo ""
		resolvectl statistics | grep 'Current Cache Size'
		tput sgr0
		echo ""
            ;;
        "Flush Local DNS-Cache")
        	tput setaf 222
		echo -e "$(tput bold) $(tput smul)\nFlushing DNS-Cache....  $(tput rmul)"    
		sleep 2
		resolvectl flush-caches
		echo ""
		resolvectl statistics | grep 'Current Cache Size'
		tput sgr0
		echo ""
            ;;
	"Quit")
            echo ""
	    break
            ;;
        *) echo "...Invalid option"
	   echo ""
	    ;;
    esac
done
