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
    Option "NaturalScrolling" "true"
    Option "DisableWhileTyping" "true"
EndSection
```

- locale [if any]

Edit your profile:

```bash
# before
sudo nvim /etc/default/libc-locales

# after
sudo xbps-reconfigure -f glibc-locales
```

```bash
# uncomment
en_US.UTF-8
```

### Setup
----------
- For minimal and base setup

- i3 installed

