require 'fog'

file_name = ARGV.first
file_description = "#{Date.today} - #{File.basename(file_name)}"
credentials = YAML.load_file('.aws.yml')
chunk_size = 8*1024*1024

glacier = Fog::AWS::Glacier.new(credentials)
vault = glacier.vaults.get('shs_backup')
upload = vault.archives.create(description: file_description, body: File.new(file_name), multipart_chunk_size: chunk_size)

puts "#{file_description} uploaded with ID #{upload.id}"
