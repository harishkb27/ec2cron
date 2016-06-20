#
# Cookbook Name:: test
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'test::create_profile' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates aws ec2cron profiles - test and test2'  do
    	expect(chef_run).to create_ec2cron_profile('test').with({aws_access_key: 'testak', aws_secret_access_key: 'testsak', region: 'eu-west-1'})
    	expect(chef_run).to create_ec2cron_profile('test2').with({aws_access_key: 'test2ak', aws_secret_access_key: 'test2sak',	region: 'eu-west-1'})
    end
  end
end