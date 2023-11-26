require "aws-sdk-s3"

class MapboxUploader
  attr_reader :body

  USERNAME = 'dedemenezes'
  CREDENTIALS_URL = "https://api.mapbox.com/uploads/v1/dedemenezes/credentials?access_token=#{ENV.fetch('MAPBOX_SUPER_KEY')}"

  def initialize(tileset_name:, file_path:)
    @file_path    = file_path
    @tileset_name = ensure_valid_name(tileset_name)
    @upload_url   = "https://api.mapbox.com/uploads/v1/dedemenezes?access_token=#{ENV.fetch('MAPBOX_SUPER_KEY')}"
    # @credentials_url = "https://api.mapbox.com/uploads/v1/dedemenezes/credentials?access_token=#{ENV.fetch('MAPBOX_SUPER_KEY')}"
  end

  def self.tileset_from_kml(tileset_name, file_path)
    sdk_ruby = new(tileset_name: tileset_name, file_path: file_path)
    sdk_ruby.tileset_from_kml
  end

  def tileset_from_kml
    @body = S3.retrieve_credentials(CREDENTIALS_URL)
    stage_file
    upload_tileset
  end

  private

  def ensure_valid_name(tileset_name)
    tileset_name.downcase.gsub(' ', '_')
  end

  # def retrieve_s3_credentials
  #   connection = Faraday.new(headers: { 'Content-Type' => 'application/json' })
  #   response = connection.post(
  #     @credentials_url,
  #     nil,
  #     { 'Content-Type' => 'application/json' }
  #   )
  #   @body = JSON.parse(response.body)
  # end

  def stage_file
    # aws_access_key_id, aws_secret_access_key
    # sessionToken
    credentials = Aws::Credentials.new(body['accessKeyId'], body['secretAccessKey'], body['sessionToken'])
    client = Aws::S3::Client.new(region: 'us-east-1', credentials:)
    object = Aws::S3::Object.new(body['bucket'], body['key'], nil, client:)
    response = object.upload_file(@file_path)
    puts "File Uploaded! zo/\nResponse: #{response}"
  rescue Aws::Errors::ServiceError => e
    puts "Couldn't upload file #{@file_path} to #{object.key}. Here's why: #{e.message}"
  end

  def upload_tileset
    connection = Faraday.new(headers: { 'Content-Type' => 'application/json', "Cache-Control" => "no-cache" })
    tile_set_body = JSON.generate(
      {
        "url" => body['url'],
        "tileset" => "#{USERNAME}.#{@tileset_name}",
        "name" => @tileset_name
      }
    )
    connection.post @upload_url, tile_set_body
  end
end
