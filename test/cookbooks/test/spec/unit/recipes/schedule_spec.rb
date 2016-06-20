#
# Cookbook Name:: test
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'test::schedule' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'sets a schedule for i-testid' do
      expect(chef_run).to create_ec2cron_schedule('start test instance').with({id: 'i-testid', state: 'start', profile: 'test'})
      expect(chef_run).to create_ec2cron_schedule('stop test instance').with({id: 'i-testid', state: 'stop', profile: 'test'})
    end
  end
end
