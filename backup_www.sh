tar -cvzf /backup/www.tar.gz tmp/* 2> /dev/null
ruby /root/backup/glacier.rb /backup/www.tar.gz
