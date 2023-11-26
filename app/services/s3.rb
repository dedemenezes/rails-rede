class S3
  class NotAuthorizedError < StandardError
    attr_reader :status, :body

    def initialize(status, msg)
      @status = status
      @body   = JSON.parse(msg)
    end
  end

  def self.retrieve_credentials(url)
    connection = Faraday.new(headers: { 'Content-Type' => 'application/json' })
    response = connection.post(
      url,
      nil,
      { 'Content-Type' => 'application/json' }
    )
    body = response.body
    raise NotAuthorizedError.new(response.status, body), body if response.status == 401

    JSON.parse(body)
  end
end
