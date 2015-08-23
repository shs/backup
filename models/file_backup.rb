# encoding: utf-8

Model.new(:file_backup, 'SHS file structure.') do
  split_into_chunks_of 4000

  sync_with Cloud::S3 do |s3|
    s3.mirror       = false
    s3.threat_count = 50

    s3.directories do |directory|
      directory.add '/var/www'
      directory.add '/etc/apache2'
      directory.add '/etc/php5'
    end
  end

  notify_by Mail
end
