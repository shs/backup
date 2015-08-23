# encoding: utf-8

Model.new(:database_backup, 'SHS forum database.') do
  split_into_chunks_of 4000

  database MySQL, :forum do |db|
    db.name               = 'shs_forum'
    db.username           = 'backup'
    db.additional_options = ['--opt']
  end

  database MySQL, :cms do |db|
    db.name               = 'shs_cms'
    db.username           = 'backup'
    db.additional_options = ['--opt']
  end

  store_with S3 do |s3|
    s3.keep = 30
  end

  compress_with Gzip

  notify_by Mail
end
