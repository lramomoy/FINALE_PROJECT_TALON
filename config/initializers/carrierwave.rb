if Rails.env.production?

    CarrierWave.configure do |config|

        config.fog_provider = 'fog/aws'                        # required
        config.fog_credentials = {
            provider:              'AWS',                        # required
            aws_access_key_id:     'AKIAINQI3JG4Y2E43CSA',                        # required unless using use_iam_profile
            aws_secret_access_key: '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',                        # required unless using use_iam_profile
            #use_iam_profile:       true,                         # optional, defaults to false
            region:                'us-east-2',                  # optional, defaults to 'us-east-1'
            #host:                  's3.example.com',             # optional, defaults to nil
            #endpoint:              'https://s3.example.com:8080' # optional, defaults to nil
        }
        config.storage = :fog
        config.fog_directory = 'mb-parlor'
        config.fog_public    = true
        config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
    end
else

    CarrierWave.configure do |config|
        config.storage = :file
        config.enable_processing = true
        config.asset_host = 'http://localhost:3000'
    end
end
