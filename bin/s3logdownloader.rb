#!?usr/bin/ruby

require 'rubygems'
require 'aws/s3'

get_sum = AWS::S3.initialize
get_sum.establish_connection!(
      :access_key_id     => 'ENV[ACCESS_KEY_ID]', 
      :secret_access_key => 'ENV[SECRET_ACCESS_KEY]',
      :use_ssl           => true
    )

get_sum.Service.buckets
