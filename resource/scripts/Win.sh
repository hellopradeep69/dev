#!/usr/bin/env bash

option=$1

Session_name=$(tmux display-message -p '#S' )
Current_win=$(tmux display-message -p '#W' )
Win_name="code"

Create_win(){

    tmux kill-window -t "$Session_name:$Win_name"

    if ! tmux list-windows -t "$Session_name" | grep -q "$Win_name"; then
        tmux new-window -t "$Session_name" -n "$Win_name" -c "${pane_current_path}"
        tmux select-window -t "$Session_name:$Current_win"
    else
        tmux select-window -t "$Session_name:$Win_name"
    fi

}

Run_it(){

    if ! tmux list-windows -t "$Session_name" | grep -q "$Win_name"; then
        tmux new-window -t "$Session_name" -n "$Win_name" -c "${pane_current_path}"
    else
        tmux select-window -t "$Session_name:$Win_name"
    fi

    tmux send-keys -t "$Session_name:$Win_name" Up Enter
    tmux select-window -t "$Session_name:$Win_name"
}

# Create_win
case "$option" in
    -c)
        Run_it
        ;;
    *)
        Create_win
        ;;
esac

