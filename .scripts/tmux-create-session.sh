#!/bin/bash

# Script to help setup a tmux session
# $1 for name of session
# $2 for session open up path
# 3 windows in the sessions:
# - main
# - nvim  -- editor
# - git   -- lazy-git or the like

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NOCOLOR='\033[0m'

# vars
NAME=
TPATH=

#####################################
# Functions
# echo help
echo_help() {
    echo -e "tmux-create-session.sh\n---\nCreates a new tmux session with some windows\nUsage: ${GREEN}\$ ${BLUE}tmux-create-session.sh ${YELLOW}-n SESSION_NAME -p PATH ${NOCOLOR}"
}

# Get args
get_args() {
    while getopts ":n:p:h" opt; do
        case $opt in
            n) NAME=$OPTARG;;
            p) TPATH=$OPTARG;;
            h) echo_help; exit 1;;
            \?)
                echo "Invalid option: -$OPTARG"
                exit 1 ;;
            :)
                echo "Option -$OPTARG requires an argument. See usage using -h."
                exit 1 ;;
        esac
    done
    
    # Check if NAME and TPATH have been populated.
    if [ -z "$NAME" ]; then
        echo -e "${YELLOW}-n ${NOCOLOR}flag mandatory. Cannot proceed without name for session. \n${RED}Exiting...${NOCOLOR}"
        exit 1
    fi
    
    if [ -z "$TPATH" ]; then
        echo -e "${YELLOW}-p ${NOCOLOR}flag mandatory. Cannot proceed without path for session. \n${RED}Exiting...${NOCOLOR}"
        exit 1
    fi
}

tmux_start_session() {
    echo -e "Creating tmux session named ${YELLOW}${NAME}${NOCOLOR} based out of ${YELLOW}${TPATH}${NOCOLOR}..."

    # start a new session and go to $TPATH
    tmux new-session -n main -s $NAME -d
    tmux send-keys "cd ${TPATH}" C-m

    # window with nvim
    tmux new-window -n nvim
    tmux send-keys "cd ${TPATH};nvim ." C-m

    # window with git
    tmux new-window -n git
    tmux send-keys "cd ${TPATH};git status" C-m
}

#####################################

#####################################
# Invoke all functions
get_args "$@"
tmux_start_session
#####################################

# Ending blank line
