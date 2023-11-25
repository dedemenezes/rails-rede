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
    stage_file
    upload_tileset
  end

  private

  def upload_tileset
    # curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -d '{
    #   "url": "http://{bucket}.s3.amazonaws.com/{key}",
    #   "tileset": "dedemenezes.traverse-bay",
    #   "name": "Traverse Bay"
    # }' 'https://api.mapbox.com/uploads/v1/dedemenezes?access_token=YOUR_MAPBOX_ACCESS_TOKEN'
    connection = Faraday.new(headers: { 'Content-Type' => 'application/json', "Cache-Control" => "no-cache" })

    tile_set_body = JSON.stringify({ "url" => body['url'], "tileset" => "dedemenezes.traverse-bay--demo", "name" => "Traverse Bay Demo 01" })
    binding.b
    response = connection.post url, body
    p response
  end

  def retrieve_s3_credentials
    connection = Faraday.new(headers: { 'Content-Type' => 'application/json' })
    url = "https://api.mapbox.com/uploads/v1/dedemenezes/credentials?access_token=#{ENV['MAPBOX_SUPER_KEY']}"
    response = connection.post(
      url,
      nil,
      { 'Content-Type' => 'application/json' }
    )
    @body = JSON.parse(response.body)
    binding.b

  end

  def stage_file
    # aws_access_key_id, aws_secret_access_key
    # sessionToken
    credentials = Aws::Credentials.new(body['accessKeyId'], body['secretAccessKey'], body['sessionToken'])
    client = Aws::S3::Client.new(region: 'us-east-1', credentials:)
    object = Aws::S3::Object.new(body['bucket'], body['key'], nil, client:)
    file_path = '/mnt/c/Users/matme/Downloads/Araruama1.kml'
    response = object.upload_file(file_path)
    binding.b

    puts "File Uploaded! zo/\nResponse: #{response}"
  rescue Aws::Errors::ServiceError => e
    puts "Couldn't upload file #{file_path} to #{object.key}. Here's why: #{e.message}"
  end
end
