require 'spec_helper'

RSpec.describe "POST /sign_up_with_email_or_username_and_password", type: :request, provider: true do
  it 'sign in user' do
    post '/auth/sign_up_with_email_or_username_and_password', params: { email_or_username: 'nandosousafr@gmail.com', password: '12345' }

    json_response = JSON.parse(response.body)
    expect(json_response).to eq(
      'id_token'      => '[ID_TOKEN]',
      'refresh_token' => '[REFRESH_TOKEN]',
      'expires_in'    => '3600'
    )
  end
end
