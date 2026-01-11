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

- locale[if any]

Edit your profile:

```bash
nano ~/.profile
```

Add:
```bash
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
```

```bash
source ~/.profile
```

### dwm
----------

- setup

