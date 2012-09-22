require 'fog'

file_name = ARGV.first
credentials = YAML.load_file('.aws.yml')

glacier = Fog::AWS::Glacier.new(credentials)
vault = glacier.vaults.get('shs_backup')
upload = vault.archives.create description: "#{Date.today} - #{file_name}", body: File.new(file_name), multipart_chunk_size: 8*1024*1024

