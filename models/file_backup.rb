# encoding: utf-8

Backup::Model.new(:file_backup, 'Backups the SHS file structure.') do
  split_into_chunks_of 5000

  sync_with Cloud::S3 do |s3|
    s3.mirror            = true
    s3.concurrency_type  = :threads
    s3.concurrency_level = 50

    s3.directories do |directory|
      directory.add '/var/www'
    end
  end
end
