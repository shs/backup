tar -cvzf /backup/www.tar.gz /var/www/* 2> /dev/null
ruby /root/backup/glacier.rb /backup/www.tar.gz
