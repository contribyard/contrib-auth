require 'spec_helper'

RSpec.describe "POST /sign_in_with_password", type: :request, provider: true do
  it 'sign in user' do
    post '/auth/sign_in_with_password', params: { email: 'nandosousafr@gmail.com', password: '12345' }

    json_response = JSON.parse(response.body)
    expect(json_response).to eq(
      'id_token'      => '[ID_TOKEN]',
      'refresh_token' => '[REFRESH_TOKEN]',
      'expires_in'    => '3600'
    )
  end
end
