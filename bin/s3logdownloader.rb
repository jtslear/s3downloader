require 'rubygems'
require 'aws/s3'


class Connect
  def initialize
    @access_key_id     = ENV['ACCESS_KEY_ID']
    @secret_access_key = ENV['SECRET_ACCESS_KEY']
  end
  
  def authenticate
    if !(@access_key_id||@secret_access_key)
      print "Please specify the following ENV variables:
        ACCESS_KEY_ID
        SECRET_ACCESS_KEY\n"
      exit
    else
      get_sum = AWS::S3::Base.establish_connection!(
        :access_key_id     => @access_key_id, 
        :secret_access_key => @secret_access_key,
        :use_ssl           => true
      )
    end
  end
end

#get_sum.connected?
get_sum = Connect.new
get_sum.authenticate
