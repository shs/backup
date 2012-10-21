# encoding: utf-8

credentials = YAML.load_file('.aws.yml')

# $ backup perform -t database_backup [-c <path_to_configuration_file>]
Backup::Model.new(:database_backup, 'Backups the SHS forum database.') do
  split_into_chunks_of 5000

  database MySQL do |db|
    db.name               = 'shs_forum'
    db.username           = 'backup'
    db.additional_options = ['--opt']
  end

  store_with S3 do |s3|
    s3.keep = 30
  end

  compress_with Gzip
end
