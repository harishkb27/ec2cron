require 'spec_helper'

describe command('aws --version 2>&1') do
	its(:stdout)  { should match /aws-cli\/[\d]{1,2}.[\d]{1,2}.[\d]{1,2}/ }
end

describe file('/root/.aws/config') do
	it { should exist }
	its(:content) { should match /\[profile test\]\nregion = eu-west-1/ }
end

describe file('/root/.aws/credentials') do
	it { should exist }
	its(:content) { should match /\[test\]\naws_access_key_id = testak\naws_secret_access_key = testsak/ }
	its(:content) { should_not match /\[test2\]\naws_access_key_id = test2ak\naws_secret_access_key = test2sak/ }
end

describe cron do
	it { should have_entry '30 07 * * 1-5 aws ec2 start-instances --instance-ids i-testid --profile test' }
	it { should have_entry '30 08 * * 1-5 aws ec2 stop-instances --instance-ids i-testid --profile test' }
end

