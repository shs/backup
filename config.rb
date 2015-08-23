# encoding: utf-8

require 'dotenv'
Dotenv.load

Backup::Storage::S3.defaults do |s3|
  s3.access_key_id     = ENV['AWS_ACCESS_KEY_ID']
  s3.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
  s3.region            = 'us-east-1'
  s3.bucket            = 'shs-backup'
  s3.path              = ''
end

Backup::Syncer::Cloud::S3.defaults do |s3|
  s3.access_key_id     = ENV['AWS_ACCESS_KEY_ID']
  s3.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
  s3.region            = 'us-east-1'
  s3.bucket            = 'shs-backup'
  s3.path              = 'file_backup'
end

Backup::Notifier::Mail.defaults do |mail|
  mail.on_success           = true
  mail.on_warning           = true
  mail.on_failure           = true

  mail.delivery_method      = :sendmail
  mail.from                 = 'backup@spellholdstudios.net'
  mail.to                   = 'backup@spellholdstudios.net'
end

Dir[File.join(File.dirname(Config.config_file), "models", "*.rb")].each do |model|
  instance_eval(File.read(model))
end
