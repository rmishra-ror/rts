# frozen_string_literal: true

require 'openssl'

module RTS
  class Client < Request
    attr_accessor :api_key, :client_certificate, :client_key, :client_certificate_path, :client_key_path
    BASE_URL = 'https://api-json.sandbox.rtsmunity.com:6220'
    include ::Api::StaticSportEventInformation
    include ::Api::LiveSportEventInformation

    def initialize(api_key:, client_certificate: nil, client_key: nil,
      client_certificate_path: nil, client_key_path: nil)
      @api_key = api_key
      configure_client_certificate(client_certificate, client_certificate_path)
      configure_client_key(client_key, client_key_path)
      validate_openssl_configuration
    end

    def request_url(path)
      "#{BASE_URL}/#{path}"
    end

    def headers
      { "X-Api-Key": api_key }
    end

    private

    def configure_client_certificate(client_certificate, client_certificate_path)
      (@client_certificate = client_certificate) && return if client_certificate
      (@client_certificate = File.read(client_certificate_path)) && return if client_certificate_path
      raise StandardError, 'client_certificate is missing'
    end

    def configure_client_key(client_key, client_key_path)
      (@client_key = client_key) && return if client_key
      (@client_key = File.read(client_key_path)) && return if client_key_path
      raise StandardError, 'client_key is missing'
    end

    def validate_openssl_configuration
      ::OpenSSL::X509::Certificate.new(client_certificate) &&
        ::OpenSSL::PKey::RSA.new(client_key)
    end

    def ssl_client_key
      ::OpenSSL::PKey::RSA.new(client_key)
    end

    def ssl_client_certificate
      OpenSSL::X509::Certificate.new(client_certificate)
    end
  end
end

# 'https://api-json.sandbox.rtsmunity.com:6220/csgo/matches',
