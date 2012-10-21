# encoding: utf-8

Backup::Model.new(:teargas_backup, 'Backups the Teargas backups (meta!).') do
  split_into_chunks_of 5000

  sync_with Cloud::S3 do |s3|
    s3.bucket            = 'teargas-backup'
    s3.path              = 'backups'
    s3.mirror            = true
    s3.concurrency_type  = :threads
    s3.concurrency_level = 50

    s3.directories do |directory|
      directory.add '/backup/teargas'
    end
  end

  notify_by Mail
end
