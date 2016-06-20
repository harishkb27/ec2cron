resource_name :ec2cron_install

property :resource_name, String, name_property: true

action :install do
	python_runtime '2'
	python_package 'awscli'
end