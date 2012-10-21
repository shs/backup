# encoding: utf-8

credentials = YAML.load_file(File.join(File.expand_path(File.dirname(__FILE__)), '.aws.yml'))

Backup::Storage::S3.defaults do |s3|
  s3.access_key_id     = credentials['aws_access_key_id']
  s3.secret_access_key = credentials['aws_secret_access_key']
  s3.region            = 'us-east-1'
  s3.bucket            = 'shs-backup'
  s3.path              = ''
end

Backup::Syncer::Cloud::S3.defaults do |s3|
  s3.access_key_id     = credentials['aws_access_key_id']
  s3.secret_access_key = credentials['aws_secret_access_key']
  s3.region            = 'us-east-1'
  s3.bucket            = 'shs-backup'
  s3.path              = 'file_backup'
end

Dir[File.join(File.dirname(Config.config_file), "models", "*.rb")].each do |model|
  instance_eval(File.read(model))
end
