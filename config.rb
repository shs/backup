# encoding: utf-8

##
# Backup v4.x Configuration
#
# Documentation: http://backup.github.io/backup
# Issue Tracker: https://github.com/backup/backup/issues

require 'dotenv'
Dotenv.load

root_path '/home/ubuntu/Backup'

Utilities.configure do
  sendmail '/usr/sbin/sendmail'
end

Storage::S3.defaults do |s3|
  s3.access_key_id     = ENV['AWS_ACCESS_KEY_ID']
  s3.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
  s3.region            = 'us-east-1'
  s3.bucket            = 'shs-backup'
  s3.path              = ''
end

Syncer::Cloud::S3.defaults do |s3|
  s3.access_key_id     = ENV['AWS_ACCESS_KEY_ID']
  s3.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
  s3.region            = 'us-east-1'
  s3.bucket            = 'shs-backup'
  s3.path              = 'file_backup'
end

Notifier::Mail.defaults do |mail|
  mail.on_success           = true
  mail.on_warning           = true
  mail.on_failure           = true

  mail.delivery_method      = :sendmail
  mail.from                 = 'backup@spellholdstudios.net'
  mail.to                   = 'backup@spellholdstudios.net'
end
