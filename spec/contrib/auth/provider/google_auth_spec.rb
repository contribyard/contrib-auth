require 'spec_helper'

RSpec.describe Contrib::Auth::Provider::GoogleAuth do
  describe '.sign_in_with_password' do
    context 'when credentials are correct' do
      it 'return idToken' do
        http_client = spy('Faraday::Connection')

        api_key  = SecureRandom.uuid
        email    = 'developers@contribyard'
        password = '12345'

        provider = Contrib::Auth::Provider::GoogleAuth.new(api_key, http_client)
        provider.sign_in_with_password(email, password)

        expect(http_client).to have_received(:post).with('accounts:signInWithPassword') do |&block|
          req = OpenStruct.new(params: {}, body: '')
          block.call(req)
          expect(req.params).to eq key: api_key
          expect(req.body).to eq "{\"email\":\"#{email}\",\"password\":\"#{password}\"}"
        end
      end
    end

    context 'when credentials are not correct' do
      pending
    end
  end
end
