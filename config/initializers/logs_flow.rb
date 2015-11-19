# see http://docs.aws.amazon.com/sdkforruby/api/index.html#Configuration

#Aws.config.update({
#  region: 'us-west-2',
#  credentials: Aws::Credentials.new('akid', 'secret'),
#})

Rails.application.config.default_region = Aws.config[:region] || ENV['AWS_REGION'] || 'us-east-1'
Rails.application.config.event_timestamp_format = '%m/%d %H:%M'
