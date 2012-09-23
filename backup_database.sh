mysqldump --user=backup --opt shs_forum > /backup/db/forum.sql 2> /dev/null
# mysqldump --user=backup --opt shs_website > /backup/db/website.sql 2> /dev/null
tar -cvzf /backup/databases.tar.gz /backup/db/*.sql 2> /dev/null
ruby /root/backup/glacier.rb /backup/databases.tar.gz
