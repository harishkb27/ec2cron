#
# Cookbook Name:: test
# Recipe:: delete_profile
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
# 

ec2cron_profile 'test2' do
	action :delete
end
