resource_name :ec2cron_schedule

property :resource_name, String, name_property: true
property :type, String, default: 'instance'
property :id, String
property :state, String
property :profile, String
property :minute, String, default: '*'
property :hour, String, default: '*'
property :day, String, default: '*'
property :month, String, default: '*'
property :weekday, String, default: '*'

action_class do
	
	def validate_type
		valid_types = ['instance']
		if valid_types.include?(new_resource.type)
			true
		else
			Chef::Log.fatal("Invalid resource type. Choose from: #{valid_types.join(',')}.")
			raise
		end
	end

	def validate_state
		valid_states = {'instance' => ['start', 'stop']}
		if valid_states[new_resource.type].include?(new_resource.state)
			true
		else
			Chef::Log.fatal("Invalid state for resource.")
			raise
		end 
	end

	def get_id
		if new_resource.id.nil?
			new_resource.resource_name
		else
			new_resource.id
		end
	end

	def get_command
		cmd = ''
		if "#{new_resource.type}" == "instance"
			cmd << "aws ec2 #{new_resource.state}-instances "
			cmd << "--instance-ids #{get_id} "
			cmd << "--profile #{new_resource.profile}"
		end
		cmd
	end

	def set_cron(action)

		package 'cron'

		cron "#{new_resource.state}_of_#{new_resource.resource_name}" do
			minute "#{new_resource.minute}"
			hour "#{new_resource.hour}"
			day "#{new_resource.day}"
			month "#{new_resource.month}"
			weekday "#{new_resource.weekday}"
			command "#{get_command}"
			action action
		end
	end

end

action :create do
	validate_type
	validate_state
	set_cron(:create)
end

action :delete do
	set_cron(:delete)
end