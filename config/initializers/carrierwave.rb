# unless Rails.env.development? || Rails.env.test?
#   CarrierWave.configure do |config|
#     config.fog_credentials = {
#       provider: 'AWS',
#       aws_access_key_id: 'Rails.application.credentials.dig(:aws, :access_key_id)',
#       aws_secret_access_key: 'Rails.application.credentials.dig(:aws, :secret_access_key)',
#       region: 'ap-northeast-1'
#     }

#     config.fog_directory = 'bucket-for-ramenmaster'
#     config.cache_storage = :fog
#   end
# end
