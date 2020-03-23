# frozen_string_literal: true

require 'rest-client'
require 'json'
module RTS
  class Request
    def get(url)
      data = RestClient::Request.execute(
        method: :get,
        url: request_url(url),
        headers: headers,
        ssl_client_cert: ssl_client_certificate,
        ssl_client_key: ssl_client_key
      )

      JSON.parse(data)
    rescue RestClient::Exception => e
      RTS::Error.on_complete(e)
    end
  end
end
