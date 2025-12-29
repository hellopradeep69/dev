## My trackpad dont work
----------

```bash
sudo nvim /usr/share/X11/xorg.conf.d/40-libinput.conf

Option "Tapping" "on"
Option "NaturalScrolling" "true"
Option "DisableWhileTyping" "true"
```

### Firewall
-----------

- needed ufw

```bash
sudo systemctl enable ufw
sudo systemctl start ufw

sudo ufw default deny incoming
sudo ufw default allow outgoing

#ssh
sudo ufw allow ssh

sudo ufw enable
```


