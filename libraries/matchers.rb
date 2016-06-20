if defined?(ChefSpec)

	ChefSpec.define_matcher :ec2cron_profile

	def create_ec2cron_profile(resource_name)
		ChefSpec::Matchers::ResourceMatcher.new(:ec2cron_profile, :create, resource_name)
	end

	def delete_ec2cron_profile(resource_name)
		ChefSpec::Matchers::ResourceMatcher.new(:ec2cron_profile, :delete, resource_name)
	end

	ChefSpec.define_matcher :ec2cron_install

	def install_ec2cron_install(resource_name)
		ChefSpec::Matchers::ResourceMatcher.new(:ec2cron_install, :install, resource_name)
	end

	ChefSpec.define_matcher :ec2cron_schedule

	def create_ec2cron_schedule(resource_name)
		ChefSpec::Matchers::ResourceMatcher.new(:ec2cron_schedule, :create, resource_name)
	end

	def delete_ec2cron_schedule(resource_name)
		ChefSpec::Matchers::ResourceMatcher.new(:ec2cron_schedule, :delete, resource_name)
	end

end