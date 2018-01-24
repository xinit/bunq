#!/bin/bash
# wrapper for pfctl add/delete.
function add_block 
    {    
    echo "* Adding"
    echo pfctl -t blockedip -T add $1
    save_block_file
    }
function rm_block 
    {    
    echo "* Deleteing"
    echo pfctl -t blockedip -T delete $1
    save_block_file
    }
function flip_block 
    {    
    echo flip $1
    #    if IP in file, remove it
    #    if IP not in file, call add_block $1
    save_block_file
    }
function list_block 
    {    
    echo LIST    
    echo pfctl -t blockedip -Ts
    }
function save_block_file 
    {
    echo SAVE
    }
function display_usage 
    {
    echo "USAGE: "
    echo "    Add address to block table: blockip -a IP/CIDR"
    echo "    Remove address from block table: blockip -d IP/CIDR"
    echo "    Display block table: blockip -l"
    exit 0
    }

# Main
while getopts a:d:hlt: option
do
    case "${option}" in
    a )     # add ip to block
            if [ -z $2 ]; then display_usage; fi
            add_block $2
            ;;        
    d )     # delete ip from block
            rm_block $2
            ;;        
    t )     # toggle ip block on/off
            flip_block $2
            ;;        
    l )     #list table
            echo "* blockedip table contains "
            ;;        
    * )     display_usage        
    ;;
    esac
done


