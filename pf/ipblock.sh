#!/bin/bash
# wrapper for pfctl add/delete.
function add_block
    {
    echo " * ADD $1"
    pfctl -t blockedip -T add $1
    save_block_file
    }
function rm_block
    {
    echo " * DELETE $1"
    pfctl -t blockedip -T delete $1
    save_block_file
    }
function flip_block
    {
    echo " * FLIP $1"
    ipexist=`pfctl -t blockedip -Ts | grep -i $1`

    # if IP not in file, add_block $1
    # if IP in file, remove $1

    if [ -z $ipexist ]; then
        add_block $1
    else
        rm_block $1
    fi

    }
function list_block
    {
    echo " * LIST"
    pfctl -t blockedip -Ts
    }
function save_block_file
    {
    # Nothing should happen after saving
    echo " * SAVE"
    pfctl -t blockedip -Ts >/etc/pf-blocked.conf
    exit 0
    }
function display_usage
    {
    echo "USAGE: "
    echo "    Add address to block table: blockip -a IP/CIDR"
    echo "    Remove address from block table: blockip -d IP/CIDR"
    echo "    Display block table: blockip -l"
    exit 0
    }

# Main
while getopts a:d:hlt: option
do
    case "${option}" in
    a )     # add ip to block
            if [ -z $2 ]; then display_usage; fi
            add_block $2
            ;;
    d )     # delete ip from block
            rm_block $2
            ;;
    f )     # flip ip block on/off
            flip_block $2
            ;;
    l )     #list table
            list_block
            ;;
    * )     display_usage
    ;;
    esac
done


