require "aws-sdk-s3"

class MapboxUploader
  attr_reader :body

  def initialize
    @upload_url      = "https://api.mapbox.com/uploads/v1/dedemenezes?access_token=#{ENV.fetch('MAPBOX_SUPER_KEY')}"
    @credentials_url = "https://api.mapbox.com/uploads/v1/dedemenezes/credentials?access_token=#{ENV.fetch('MAPBOX_SUPER_KEY')}"
  end

  def self.tileset_from_kml
    sdk_ruby = new
    sdk_ruby.tileset_from_kml
  end

  def tileset_from_kml
    retrieve_s3_credentials
    stage_file
    upload_tileset
  end

  private

  def retrieve_s3_credentials
    connection = Faraday.new(headers: { 'Content-Type' => 'application/json' })
    response = connection.post(
      @credentials_url,
      nil,
      { 'Content-Type' => 'application/json' }
    )
    @body = JSON.parse(response.body)
    p body
  end

  def stage_file
    # aws_access_key_id, aws_secret_access_key
    # sessionToken
    credentials = Aws::Credentials.new(body['accessKeyId'], body['secretAccessKey'], body['sessionToken'])
    client = Aws::S3::Client.new(region: 'us-east-1', credentials:)
    object = Aws::S3::Object.new(body['bucket'], body['key'], nil, client:)
    file_path = '/mnt/c/Users/matme/Downloads/Araruama1.kml'
    response = object.upload_file(file_path)
    puts "File Uploaded! zo/\nResponse: #{response}"
  rescue Aws::Errors::ServiceError => e
    puts "Couldn't upload file #{file_path} to #{object.key}. Here's why: #{e.message}"
  end

  def upload_tileset
    connection = Faraday.new(headers: { 'Content-Type' => 'application/json', "Cache-Control" => "no-cache" })
    tile_set_body = JSON.generate({ "url" => body['url'], "tileset" => "dedemenezes.traverse-bay--demo", "name" => "Traverse Bay Demo 01" })
    response = connection.post @upload_url, tile_set_body
    p response
  end
end
