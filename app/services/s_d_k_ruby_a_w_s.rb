require "aws-sdk-s3"

class SDKRubyAWS
  attr_reader :body

  def initialize
  end

  def self.run
    sdk_ruby = new
    sdk_ruby.stage_into_bucket
    # 2. stage file into s3 bucket
    # 3. upload from s3 staged
    # 4. add new tileset source to map
    # "https://api.mapbox.com/uploads/v1/dedemenezes/credentials?access_token=#{ENV['MAPBOX_SUPER_KEY']}"
  end

  def stage_into_bucket
    retrieve_s3_credentials
    upload_file
  end

  private

  def retrieve_s3_credentials
    connection = Faraday.new(headers: { 'Content-Type' => 'application/json' })
    url = "https://api.mapbox.com/uploads/v1/dedemenezes/credentials?access_token=#{ENV['MAPBOX_SUPER_KEY']}"
    response = connection.post(
      url,
      nil,
      { 'Content-Type' => 'application/json' }
    )
    @body = JSON.parse(response.body)
  end

  def upload_file
    # aws_access_key_id, aws_secret_access_key
    # sessionToken
    credentials = Aws::Credentials.new(body['accessKeyId'], body['secretAccessKey'], body['sessionToken'])
    client = Aws::S3::Client.new(region: 'us-east-1', credentials:)
    object = Aws::S3::Object.new(body['bucket'], body['key'], nil, client:)
    file_path = '/mnt/c/Users/matme/Downloads/Araruama1.kml'
    response = object.upload_file(file_path)
    puts "File Uploaded! zo/\nObject: #{response}"
  rescue Aws::Errors::ServiceError => e
    puts "Couldn't upload file #{file_path} to #{object.key}. Here's why: #{e.message}"
  end
end
