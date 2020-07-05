CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws' # required
  config.fog_credentials = {
    provider: 'AWS', # required
    aws_access_key_id: Rails.application.credentials.aws[:access_key_id],
    aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],
    region: 'ap-northeast-1' # optional, defaults to 'us-east-1' オハイオ＝us-east-2
    # host:                  's3.example.com',             # optional, defaults to nil
    # endpoint:              'https://s3.example.com:8080' # optional, defaults to nil
  }
  config.fog_directory  = 'bucket-for-ramenmaster' # required
  config.fog_public     = false                                                 # optional, defaults to true
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
end
