sudo firewall-cmd --permanent --add-port=8096/tcp
sudo firewall-cmd --reload

sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --reload

# sudo firewall-cmd --permanent --remove-port=8096/tcp
# sudo firewall-cmd --reload
