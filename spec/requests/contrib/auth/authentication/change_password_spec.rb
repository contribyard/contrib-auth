require 'spec_helper'

RSpec.describe "POST /change_password", type: :request, provider: true do
  it 'changes the user password' do
    post '/auth/change_password', params: { id_token: '[ID_TOKEN]', password: 'newpass', password_confirmation: 'newpass' }

    expect(response.status).to eq 200
    json_response = JSON.parse(response.body)
    expect(json_response).to eq(
      'id_token'      => '[ID_TOKEN]',
      'refresh_token' => '[REFRESH_TOKEN]',
      'expires_in'    => '3600',
      'email'         => '[user@example.com]'
    )
  end
end
