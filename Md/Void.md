# ** VOID LINUX **
----------
### a lot and lot of problem

- Touchpad
- locale
- tmux showing weird symbol

#### Solution

- Touchpad | /etc/X11/xorg.conf.d/40-libinput.conf

```conf
Section "InputClass"
	Identifier "libinput touchpad catchall"
	MatchIsTouchpad "on"
	MatchDevicePath "/dev/input/event*"
	Driver "libinput"
	Option "Tapping" "on"
	Option "NaturalScrolling" "true"
	Option "ClickMethod" "clickfinger"
	Option "TappingButtonMap" "lrm"
	Option "DisableWhileTyping" "true"
EndSection
```


### dwm
----------

- setup

