#!/usr/bin/env bash

# adb shell pm list users
# adb shell am get-current-user

# adb shell pm uninstall --user 0

Users=13

# Google
adb shell pm uninstall --user $Users com.google.android.apps.subscriptions.red
adb shell pm uninstall --user $Users com.google.android.apps.nbu.files
adb shell pm uninstall --user $Users com.google.android.calendar
adb shell pm uninstall --user $Users com.google.android.contacts
adb shell pm uninstall --user $Users com.google.android.videos
adb shell pm uninstall --user $Users com.google.android.apps.youtube.music
adb shell pm uninstall --user $Users com.google.android.apps.docs
adb shell pm uninstall --user $Users com.google.android.gm
adb shell pm uninstall --user $Users com.google.android.apps.tachyon
adb shell pm uninstall --user $Users com.google.android.dialer
adb shell pm uninstall --user $Users com.google.android.deskclock
adb shell pm uninstall --user $Users com.google.android.calculator
adb shell pm uninstall --user $Users com.google.android.apps.messaging
adb shell pm uninstall --user $Users com.google.android.apps.googleassistant
adb shell pm uninstall --user $Users com.google.android.apps.photos
adb shell pm uninstall --user $Users com.google.android.apps.messaging
adb shell pm uninstall --user $Users com.google.android.apps.maps
adb shell pm uninstall --user $Users com.android.chrome

# idk
adb shell pm uninstall --user $Users com.handmark.expressweather

# moto
adb shell pm uninstall --user $Users com.orange.update
adb shell pm uninstall --user $Users com.ironsource.appcloud.oobe.hutchison
adb shell pm uninstall --user $Users com.motorola.journal
adb shell pm uninstall --user $Users com.motorola.help
adb shell pm uninstall --user $Users com.motorola.timeweatherwidget
adb shell pm uninstall --user $Users com.motorola.brapps
adb shell pm uninstall --user $Users com.motorola.audiorecorder

# Experimental
if [[ $Users != "0" ]]; then
	echo "Optional thingy"
	# Moto
	adb shell pm uninstall --user $Users com.motorola.moto
	# Moto connect
	adb shell pm uninstall --user $Users com.motorola.mobiledesktop
	# motonotes
	adb shell pm uninstall --user $Users com.motorola.stylus
	# moto help
	adb shell pm uninstall --user $Users com.motorola.genie
	# moto secure
	adb shell pm uninstall --user $Users com.motorola.securityhub
	# Google thingy
	adb shell pm uninstall --user $Users com.google.android.googlequicksearchbox
	adb shell pm uninstall --user $Users com.google.android.youtube
fi

echo "Done setup"
