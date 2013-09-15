require 'rubygems'
require 'yaml'
require 'aws-sdk'

config_file = File.join(File.dirname(__FILE__),
                        "config.yml")

unless File.exist?(config_file)
  puts <<END
    Put your credentials in config.yml as follows:

    access_key_id: YOUR_ACCESS_KEY_ID
    secret_access_key: YOUR_SECRET_ACCESS_KEY
END
  exit 1
end

config = YAML.load(File.read(config_file))

unless config.kind_of?(Hash)
  puts <<END
  Your config.yml is formatted incorrectly.  Please use the following format:

  access_key_id: YOUR_ACCESS_KEY_ID
  secret_access_key: YOUR_SECRET_ACCESS_KEY
END
  exit 1
end

log_files = AWS::S3.new(config)

log_files.buckets.each do |bucket|
  puts bucket.name
end
