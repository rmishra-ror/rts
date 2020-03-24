RSpec.describe RTS do
  it 'has a version number' do
    expect(RTS::VERSION).not_to be nil
  end

  describe RTS::Client do
    let(:client) {}

    it 'should raise error if certificate  missing' do
      expect do
        RTS::Client.new(api_key: 'asasa3fxvwervcv', client_key: 'client_key')
      end.to raise_error(StandardError)
    end

    it 'should raise error if certificate key is missing' do
      expect do
        RTS::Client.new(api_key: 'asasa3fxvwervcv', client_certificate: 'client_certificate')
      end.to raise_error(StandardError)
    end

    it 'should raise OpenSSL::X509::CertificateError if certificate is incorrect' do
      expect do
        RTS::Client.new(api_key: 'asasa3fxvwervcv',
                        client_certificate: 'client_certificate',
                        client_key: File.read('spec/fixtures/rts.key'))
      end.to raise_error(OpenSSL::X509::CertificateError)
    end

    it 'should raise OpenSSL::PKey::RSAError if key is incorrect' do
      expect do
        RTS::Client.new(api_key: 'asasa3fxvwervcv',
                        client_certificate: File.read('spec/fixtures/rts.crt'),
                        client_key: 'client_key')
      end.to raise_error(OpenSSL::PKey::RSAError)
    end

    it 'should exixts' do
      expect(RTS::Client.new(api_key: 'asasa3fxvwervcv',
                             client_certificate: File.read('spec/fixtures/rts.crt'),
                             client_key: File.read('spec/fixtures/rts.key'))).to be_kind_of(RTS::Client)
    end

    it 'should create client if key and certificate is load from file path' do
      expect(RTS::Client.new(api_key: 'asasa3fxvwervcv',
                             client_certificate_path: 'spec/fixtures/rts.crt',
                             client_key_path: 'spec/fixtures/rts.key')).to be_kind_of(RTS::Client)
    end
  end
end
