tar -cvzf /backup/www.tar.gz tmp/* 2> /dev/null
ruby glacier.rb /backup/www.tar.gz
