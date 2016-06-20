# ec2cron Cookbook


Provides resources for scheduling ec2 instances to start and stop at pre-defined intervals. Installs AWS cli and manages user profiles as per different security credentials.

## Requirements

### Platforms

- Debian / Ubuntu derivatives

### Chef

- Chef 12.1+

### Cookbooks

- poise-python

## Usage

This cookbook makes it really easy to manage the scheduling of aws ec2 instances. It provides custom resources to install and manage the aws command line interface and profiles associated with the same. Built upon the cron chef resource, the actions(start/stop) can be defined to run at specific times using the custom resources of this cookbook. The best way to understand the usage is to look at the test cookbook at [test/cookbooks/test/recipes](https://github.com/harishkb27/ec2cron/tree/master/test/cookbooks/test/recipes).

## Recipes

### default

The default recipe installs the aws cli with python 2 runtime using the `ec2cron_install` custom resource. Include this recipe to start with creating the user profiles using `ec2cron_profile` custom resource.

```ruby
include_recipe 'ec2cron::default'
```

## Resources (providers)

### ec2cron_profile

ec2cron_profile manages user profiles used to perform various aws cli actions.

#### properties

- `profile_name`: Name of the profile
- `aws_access_key`: AWS access key
- `aws_secret_access_key`: AWS secret access key
- `region`: AWS region

#### actions

- `create`
- `delete`

#### example

```ruby
include_recipe 'ec2cron::default'

ec2cron_profile 'test' do
	aws_access_key 'yourawsaccesskey'
	as_secret_access_key 'yourawssecretaccesskey'
	region 'eu-west-1'
end

ec2cron_profile 'test' do
	action :delete
end
```

### ec2cron_schedule

ec2cron_schedule manages the scheduling of aws ec2 instances in a cron-style declaration.

#### properties

- `type`: The type of ec2 resource with the default being - *instance*
- `id`: The c2 resource id. eg: instance-id
- `state`: The desired state of the resource. eg: start
- `profile`: The user profile to be used as created by *ec2cron_profile*
- `minute`: Minute at which the action needs to be performed, default being *(every minute)
- `hour`: Hour at which the needs to be performed, default being *(every hour)
- `day`: Day of action, default being *(everyday)
- `month`: Month of action, default being *(every month)
- `weekday`: Day of the week starting from 0-sunday to 6-saturday, default being *(every day of the week)

#### actions

- `create`
- `delete`

#### example

```ruby
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
	hour '20'
	weekday '1-5'
	action :create
end
```

## Testing

### Unit testing

Custom matchers have been exposed for the resources described above. You can use the apis in your unit tests. Find an implementation of ec2cron [Chefspec](https://github.com/sethvargo/chefspec) unit tests in [test/cookbooks/test/spec/unit/recipes/](https://github.com/harishkb27/ec2cron/tree/master/test/cookbooks/test/spec/unit/recipes).

### Integration testing

An implementation of [Serverspec](http://serverspec.org) integration testing of resources managed by ec2cron cookbook can be found at [test/integration/default/serverspec/default_spec.rb](https://github.com/harishkb27/ec2cron/blob/master/test/integration/default/serverspec/default_spec.rb)

## License & Authors

- Author: Harish K B ([harish.kb27@gmail.com](mailto:harish.kb27@gmail.com))

```text
The MIT License

Copyright (C) 2016 by Harish K Bujanga

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```