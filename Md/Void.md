# ** VOID LINUX **
----------
### a lot and lot of problem

- Touchpad
- locale
- tmux showing weird symbol

#### Solution

- Touchpad | /etc/X11/xorg.conf.d/40-libinput.conf

```bash
sudo mkdir -p /etc/X11/xorg.conf.d
sudo nano /etc/X11/xorg.conf.d/90-touchpad.conf
```

```conf
Section "InputClass"
    Identifier "touchpad"
    MatchIsTouchpad "on"
    Driver "libinput"
    Option "Tapping" "on"
    Option "NaturalScrolling" "true"       # optional
    Option "DisableWhileTyping" "true"     # optional
EndSection
```

- locale [if any]

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

