sudo echo "supervised systemd" >> /etc/redis/redis.conf
sudo systemctl restart redis-server
sudo systemctl enable redis-server