#!/usr/bin/ruby
 
require 'rubygems'
require 'aws-sdk'

if ARGV.size < 2
  puts "Usage: " + File.basename(__FILE__) + " {db_instance_identifier} {output_dir}"
  exit(1)
end

AWS.config({ :region => 'ap-northeast-1' })
# Not IAM Role
#AWS.config({
#  :region => 'ap-northeast-1',
#  :access_key_id => 'XXXXXXXXXX',
#  :secret_access_key => 'XXXXXXXXX'
#})
db_instance_identifier = ARGV[0]
max_records            = 0
number_of_lines        = 0
log_dir = ARGV[1]
 
client = AWS::RDS.new.client
 
log_files = client.describe_db_log_files({
  :db_instance_identifier => db_instance_identifier,
  :max_records            => max_records
})
 
log_files.describe_db_log_files.each do |log_file|
 
  additional_data_pending = true
  marker                  = '0:0'
 
    while additional_data_pending do
 
    log = client.download_db_log_file_portion({
      :db_instance_identifier => db_instance_identifier,
      :log_file_name          => log_file.log_file_name,
      :marker                 => marker,
      :number_of_lines        => number_of_lines
    })
 
    log_file_name = log_dir + '/' + log_file.log_file_name.split("/")[1]
    File.open(log_file_name, "a") do |io|
      if !log.log_file_data.nil? then
        io.print(log.log_file_data)
      end
    end
    timestamp = log_file.last_written / 1000
    File::utime(timestamp, timestamp, log_file_name)
 
    additional_data_pending = log.additional_data_pending
    marker                  = log.marker
 
  end
 
end
