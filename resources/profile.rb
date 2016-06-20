resource_name :ec2cron_profile

property :profile_name, String, name_property: true, required: true
property :aws_access_key, String
property :aws_secret_access_key, String
property :region, String, default: 'eu-west-1'

action_class do

	def validate_region
		valid_regions = ['eu-west-1', 'ap-southeast-1', 'ap-southeast-2', 'eu-central-1', 'ap-northeast-2',
			'ap-northeast-1', 'us-east-1', 'sa-east-1', 'us-west-1', 'us-west-2']
		if valid_regions.include? new_resource.region
			true
		else
			Chef::Log.fatal("Invalid region provided. Choose from #{valid_regions.join(',')}.")
			raise
		end
	end

	def aws_config_file_path
		@aws_config_file_path ||= "/root/.aws/config"
	end

	def aws_credentials_file_path
		@aws_credentials_file_path ||= "/root/.aws/credentials"
	end

	def load_file(filepath)
		if ::File.exist?(filepath)
			configs = IniFile.load(filepath)
		else
			configs = IniFile.new
		end
		configs
	end

	def profile_data
		configs = load_file(aws_config_file_path)
		configs["profile #{new_resource.profile_name}"] = {
			'region' => new_resource.region
		}
		configs
	end

	def credentials_data
		credentials = load_file(aws_credentials_file_path)
		credentials["#{new_resource.profile_name}"] = {
			'aws_access_key_id' => "#{new_resource.aws_access_key}",
			'aws_secret_access_key' => "#{new_resource.aws_secret_access_key}"
		}
		credentials
	end

	def delete_profile(profile_name)
		configs = load_file(aws_config_file_path)
		if configs.has_section?("profile #{profile_name}")
			configs.delete_section("profile #{profile_name}")
		end
		credentials = load_file(aws_credentials_file_path)
		if credentials.has_section?(profile_name)
			credentials.delete_section(profile_name)
		end
		return configs, credentials
	end

end

action :create do 

	validate_region

	require 'inifile'

	directory 'aws cli home' do
		path ::File.dirname(aws_config_file_path)
		action :create
	end

	file aws_config_file_path do
		content "#{profile_data}"
	end

	file aws_credentials_file_path do
		content "#{credentials_data}"
	end

end

action :delete do
	
	configs, credentials = delete_profile(new_resource.profile_name)
	file aws_config_file_path do
		content "#{configs}"
	end

	file aws_credentials_file_path do
		content "#{credentials}"
	end
	
end