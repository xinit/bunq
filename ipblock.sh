#!/bin/bash

function add_block {
    echo add $1
}

function rm_block {
    echo delete $1
}

function flip_block {
    echo flip $1
}

function list_block {    
    echo LIST
    echo pfctl -t blockedip -Ts

}

function save_block_file {    echo SAVE}


# wrapper for pfctl add/delete. 

while getopts a:d:lt: option
do
    case "${option}" in
        a )     # add ip to block
                add_block $2
        ;;
        d )     # delete ip from block
                rm_block $2
        ;;
        t )     # toggle ip block on/off
                flip_block $2
        ;;        
        l )     #list table
                echo "* blockedip table contains "
        ;;
        * )     echo "USAGE: "
                echo "Add address to block table: blockip [-a] IP/CIDR"
                echo "Remove address from block table: blockip [-d] IP/CIDR"                 
                echo "List block table: blockip -l"         
        ;;    esac
    done;
        




# pfctl -t blockedip -T add 192.168.1.115


