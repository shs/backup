# RAID Controller docs: https://wiki.hetzner.de/index.php/Adaptec_RAID_Controller/en

# Turn off password-based SSH access

cp /etc/ssh/sshd_config /etc/ssh/sshd_config.factory-defaults
chmod a-w /etc/ssh/sshd_config.factory-defaults

vi /etc/ssh/sshd_config
# PasswordAuthentication no

service ssh restart

# Before we do anything else
apt-get update

# S.M.A.R.T Monitoring Tools
apt-get install smartmontools
vi /etc/default/smartmontools
# Uncomment the line start_smartd=yes.

vi /etc/smartd.conf

# Comment out default config and use:
# DEFAULT -d sat -a -m sconrad@spellholdstudios.net -M exec /usr/share/smartmontools/smartd-runner
# /dev/sg1 -s (S/../.././01|L/../.././11)
# /dev/sg2 -s (S/../.././02|L/../.././12)
# /dev/sg3 -s (S/../.././03|L/../.././13)
# /dev/sg4 -s (S/../.././04|L/../.././14)

service smartmontools restart

# Install VM

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
#   address   5.9.55.69
#   netmask   255.255.255.224
#   gateway   5.9.55.65
#   # default route to access subnet
#   up route add -net 5.9.55.64 netmask 255.255.255.224 gw 5.9.55.65 eth0

# iface eth0 inet6 static
#   address 2a01:4f8:161:514a::2
#   netmask 64
#   gateway fe80::1

# auto br0
# iface br0 inet static
#    bridge_ports eth0
#    bridge_fd 0
#    address 5.9.55.69
#    netmask 255.255.255.224
#    pointopoint 5.9.55.65
#    gateway 5.9.55.65
#    up route add -host 5.9.55.88 dev br0
#    up route add -host 5.9.55.90 dev br0



vi /var/lib/lxc/shs/config

# Network configuration
# lxc.network.type = veth
# lxc.network.flags = up
# lxc.network.link = br0
# lxc.network.veth.pair = veth_shs # this has to be unique for each LXC container
# lxc.network.ipv4 = 5.9.55.88/32

vi /var/lib/lxc/shs/rootfs/etc/network/interfaces

# auto lo
# iface lo inet loopback
# auto eth0
# iface eth0 inet static
#     address 5.9.55.88
#     netmask 255.255.255.224
#     pointopoint 5.9.55.69
#     gateway 5.9.55.69
#     up route add default gw 5.9.55.69

reboot

# VM

lxc-start -n shs -d

lxc-console -n shs
passwd

# Verify internet connection

ping google.com

sudo apt-get update

# Apache/PHP/MySQL

sudo apt-get install lamp-server^
sudo apt-get install php5-gd
sudo apt-get install sendmail

sudo sendmailconfig
sudo vi /etc/php5/apache2/php.ini
sudo /etc/init.d/apache2 restart

# Backups
sudo apt-get update
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

mysql -u root -p
> GRANT SELECT, LOCK TABLES ON shs_forum.* TO 'backup'@'localhost';
> GRANT SELECT, LOCK TABLES ON shs_cms.* TO 'backup'@'localhost';





sudo apt-get install awscli
aws configure
aws s3 sync s3://shs-backup .




chmod 777 $(find /var/www/forums/uploads -type d)
chmod 777 $(find /var/www/downloads -type d)




sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update

sudo apt-get install php5.6 php5.6-fpm
sudo apt-get install libapache2-mod-php5.6 php5.6-cgi php5.6-cli php5.6-curl php5.6-imap php5.6-gd php5.6-mysql php5.6-pgsql php5.6-sqlite3 php5.6-mbstring php5.6-json php5.6-bz2 php5.6-mcrypt php5.6-xmlrpc php5.6-gmp php5.6-xsl php5.6-soap php5.6-xml php5.6-zip php5.6-dba
sudo a2dismod mpm_event
sudo a2enmod mpm_prefork
sudo a2enmod php5.6
systemctl restart apache2


# Follow this: https://www.devart.com/dbforge/mysql/how-to-install-mysql-on-ubuntu/
wget https://dev.mysql.com/get/mysql-apt-config_0.8.12-1_all.deb
sudo dpkg -i mysql-apt-config_0.8.12-1_all.deb
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 467B942D3A79BD29
sudo apt update
sudo apt install -f mysql-client=5.7* mysql-community-server=5.7* mysql-server=5.7*

















