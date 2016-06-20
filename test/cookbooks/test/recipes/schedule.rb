#
# Cookbook Name:: test
# Recipe:: schedule
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
# 

ec2cron_schedule 'start test instance' do
	id 'i-testid'
	type 'instance'
	state 'start'
	profile 'test'
	minute '30'
	hour '07'
	weekday '1-5'
	action :create
end

ec2cron_schedule 'stop test instance' do
	id 'i-testid'
	type 'instance'
	state 'stop'
	profile 'test'
	minute '30'
	hour '08'
	weekday '1-5'
	action :create
end