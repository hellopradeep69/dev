option=$1

Enable() {
	sudo systemctl enable --now jellyfin
}

Disable() {
	sudo systemctl stop jellyfin
	sudo systemctl disable jellyfin
}

case "$option" in
-e)
	Enable
	;;
-d)
	Disable
	;;
*)
	echo "Usage: $0 <arguments>"
	echo "$0 -e        to enable jelyfin"
	echo "$0 -d        to disable jelyfin"
	;;
esac
