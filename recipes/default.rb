#
# Cookbook Name:: ec2cron
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

ec2cron_install 'install aws cli with python2 runtime'

chef_gem 'inifile' do
	compile_time false
end