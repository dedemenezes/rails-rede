require 'test_helper'

class S3Test < ActiveSupport::TestCase
  test '#retrieve_s3_credentials successfully retrieves and parses credentials' do
    response_body = {
      'accessKeyId' => '123',
      'secretAccessKey' => '456',
      'sessionToken' => '789'
    }

    stub_request(:any, 'http://www.example.com/credentials')
      .to_return_json(body: response_body)
    response = S3.retrieve_credentials('http://www.example.com/credentials')

    assert_equal '123', response['accessKeyId']
    assert_equal '456', response['secretAccessKey']
    assert_equal '789', response['sessionToken']
  end

  test '#retrieve_s3_credentials handles unexpected JSON format in the response' do
    # Your test code here
  end

  test '#retrieve_s3_credentials handles Faraday connection error' do
    # Your test code here
  end

  test '#retrieve_s3_credentials raises a specific exception on failure' do
    stub_request(:any, 'http://www.example.com/credentials?access_token=123').
      to_return_json(status: 401, body: { 'message' => 'Not Authorized - Invalid Token' })

    assert_raises(S3::NotAuthorizedError) do
      S3.retrieve_credentials('http://www.example.com/credentials?access_token=123')
    end
  end

end
