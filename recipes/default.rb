#
# Cookbook Name:: rds_backup_log
# Recipe:: default
#
# Copyright 2014, bageljp
#
# All rights reserved - Do Not Redistribute
#

gem_package "aws-sdk"

%w(
  rds-backup-log.bash
  rds-download-log.rb
  rds-event.bash
  rds-rename-log.bash
).each do |t|
  template "#{node['rds_backup_log']['root_dir']}/#{t}" do
    user "#{node['rds_backup_log']['user']}"
    group "#{node['rds_backup_log']['group']}"
    mode 00755
  end
end
  
cron "RDS backup log : event" do
  user "root"
  command "#{node['rds_backup_log']['root_dir']}/rds-event.bash #{node['rds_backup_log']['backup_dir']}/rds/event"
  hour "#{node['rds_backup_log']['cron']['hour']}"
  minute "0"
end

cron_minute = node['rds_backup_log']['cron']['minute'].to_i

node['rds_backup_log']['instances'].each do |instance|
  cron "RDS backup log : instance[#{instance}]" do
    user "#{node['rds_backup_log']['cron']['user']}"
    command "#{node['rds_backup_log']['root_dir']}/rds-backup-log.bash #{instance} #{node['rds_backup_log']['backup_dir']}/rds/#{instance}"
    hour "#{node['rds_backup_log']['cron']['hour']}"
    minute cron_minute
  end

  cron_minute = cron_minute + node['rds_backup_log']['cron']['minute'].to_i
end
