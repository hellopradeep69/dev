# ** VOID LINUX **
----------
### a lot and lot of problem

- Touchpad
- locale
- tmux showing weird symbol
- volume
    - sol : (refer) [https://www.reddit.com/r/voidlinux/comments/10t5yc0/i_cant_get_thunar_to_show_partitions_and_the/]
- thunar from xfce
    - sol : (refer) [https://www.reddit.com/r/voidlinux/comments/y6xtb6/sound_not_working_in_void_linux/]

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




#### I have things enabled
----------
```bash
run: /var/service/agetty-tty1: (pid 702) 9381s
run: /var/service/agetty-tty2: (pid 689) 9381s
run: /var/service/agetty-tty3: (pid 688) 9381s
run: /var/service/agetty-tty4: (pid 681) 9381s
run: /var/service/agetty-tty5: (pid 679) 9381s
run: /var/service/agetty-tty6: (pid 690) 9381s
run: /var/service/alsa: (pid 706) 9381s; run: log: (pid 705) 9381s
run: /var/service/chronyd: (pid 709) 9381s; run: log: (pid 708) 9381s
run: /var/service/dbus: (pid 712) 9381s; run: log: (pid 710) 9381s
run: /var/service/elogind: (pid 697) 9381s; run: log: (pid 696) 9381s
run: /var/service/lightdm: (pid 704) 9381s; run: log: (pid 703) 9381s
run: /var/service/NetworkManager: (pid 695) 9381s; run: log: (pid 692) 9381s
run: /var/service/polkitd: (pid 700) 9381s; run: log: (pid 698) 9381s
run: /var/service/sshd: (pid 713) 9381s; run: log: (pid 711) 9381s
run: /var/service/udevd: (pid 687) 9381s; run: log: (pid 686) 9381s
```
