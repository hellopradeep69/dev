#!/usr/bin/env bash

option=$1

# start
Enable() {
	sudo systemctl start bluetooth
	sudo systemctl enable bluetooth
}

# disable
Disable() {
	sudo systemctl stop bluetooth
	sudo systemctl disable bluetooth
}

case "$option" in
-enable)
	Enable
	;;
-e)
	Enable
	;;
-disable)
	Disable
	;;
-d)
	Disable
	;;
*)
	echo "$0 -e to enable "
	echo "$0 -d to disable "
	;;
esac
