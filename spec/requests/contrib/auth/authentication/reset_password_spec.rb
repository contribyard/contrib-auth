require 'spec_helper'

RSpec.describe "POST /reset_password", type: :request, provider: true do
  it 'sign in user' do
    post '/auth/reset_password', params: { email_or_username: 'nandosousafr@gmail.com' }

    expect(response.status).to eq 200
  end
end
