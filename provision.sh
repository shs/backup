apt-get update
apt-get install lxc
apt-get install bridge-utils
echo 1 > /proc/sys/net/ipv4/ip_forward

lxc-checkconfig

lxc-create -n shs -t ubuntu

lxc-ls --fancy

mkdir /etc/lxc/auto
ln -s /var/lib/lxc/shs/config /etc/lxc/auto/shs.conf

vi /etc/network/interfaces

# ### Hetzner Online GmbH - installimage
# # Loopback device:
# auto lo
# iface lo inet loopback

# # device: eth0
# auto  eth0
# iface eth0 inet static
#   address   78.46.48.67
#   netmask   255.255.255.224
#   gateway   78.46.48.65
#   # default route to access subnet
#   up route add -net 78.46.48.64 netmask 255.255.255.224 gw 78.46.48.65 eth0

# iface eth0 inet6 static
#   address 2a01:4f8:110:1386::2
#   netmask 64
#   gateway fe80::1

# auto br0
# iface br0 inet static
#    bridge_ports eth0
#    bridge_fd 0
#    address 78.46.48.67
#    netmask 255.255.255.224
#    pointopoint 78.46.48.65
#    gateway 78.46.48.65
#    up route add -host 78.46.53.122 dev br0
#    up route add -host 78.46.53.124 dev br0
vi /var/lib/lxc/shs/config

# # Network configuration
# lxc.network.type = veth
# lxc.network.flags = up
# lxc.network.link = br0
# lxc.network.veth.pair = veth_cms
# lxc.network.ipv4 = 78.46.53.122/32

vi /var/lib/lxc/shs/rootfs/etc/network/interfaces

# auto lo
# iface lo inet loopback
# auto eth0
# iface eth0 inet static
#     address 78.46.53.122
#     netmask 255.255.255.224
#     pointopoint 78.46.48.67
#     gateway 78.46.48.67
#     up route add default gw 78.46.48.67


# VM

lxc-start -n shs -d

lxc-console -n shs
passwd

sudo apt-get update

# Apache/PHP/MySQL

sudo apt-get install lamp-server^
sudo apt-get install php5-gd
sudo apt-get install sendmail

sudo sendmailconfig
sudo vi /etc/php5/apache2/php.ini
sudo /etc/init.d/apache2 restart

# Backups

sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

cd
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

rbenv install 2.2.2
rbenv global 2.2.2
ruby -v

echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler

git clone https://github.com/shs/backup.git Backup
cd Backup
bundle
rbenv rehash
backup check







sudo apt-get install awscli
aws configure
aws s3 sync s3://shs-backup .




chmod 777 $(find /var/www/forums/uploads -type d)



