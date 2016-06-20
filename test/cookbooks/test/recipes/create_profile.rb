#
# Cookbook Name:: test
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'ec2cron::default'

ec2cron_profile 'test' do
	aws_access_key 'testak'
	aws_secret_access_key 'testsak'
	region 'eu-west-1'
end

ec2cron_profile 'test2' do
	aws_access_key 'test2ak'
	aws_secret_access_key 'test2sak'
	region 'eu-west-1'
end