require 'rubygems'
require 'aws-sdk'

debug = true

config_file = File.join(File.dirname(__FILE__),
                        "../config.yml")

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

aws_session = AWS::S3.new(config)
bucket_objects = Hash.new

if !ARGV[0] then
  aws_session.buckets.each do |bucket|
    puts bucket.name
  end
  exit
end
ARGV.each do |bucket_name|
  available_bucket = aws_session.buckets[bucket_name]
  if available_bucket.exists? then
    available_bucket.objects.each do |bucket_item|
      bucket_objects[bucket_item.key] = bucket_name
    end
  else
    puts "#{bucket_name} does not exist."
  end
end

if debug
  dir_name = Dir.new(/(^.+\/)/.match(bucket_objects.keys.first).to_str)
  if dir_name.exists?(dir_name) then
    puts YAY
  else
    puts LAME
  end
  bucket_objects.each do |key, value|
    puts "#{key} is in bucket #{value}"
  end
end

bucket_objects.each do |key,value|
  obj = aws_session.buckets[value].objects[key]
  File.open(key, 'wb') do |file|
    obj.read do |chunk|
      file.write(chunk)
    end
  end
end

