## My trackpad dont work
----------

- touchpad
```bash
sudo nvim /usr/share/X11/xorg.conf.d/40-libinput.conf

Option "Tapping" "on"
Option "NaturalScrolling" "true"
Option "DisableWhileTyping" "true"
```

### Locale
----------

```bash
sudo nvim /etc/locale.gen
sudo locale-gen
```

