require 'rails_helper'

RSpec.describe 'User Registration' do
  it 'creates a user and generates a unique api key' do
    params = {email: "yeayea@ok.com",
      password: "password",
      password_confirmation: "password"}

    post '/api/v1/users', params: params

    expect(response).to be_successful
    expect(response.status).to eq(201)

    user_data = JSON.parse(response.body)
    user = User.last
    expected_keys = ['email', 'api_key']

    expect(user_data['data']['type']).to eq("users")
    expect(user_data['data']['attributes'].keys).to eq(expected_keys)
    expect(user_data['data']['attributes']['api_key']).to eq(user.api_key)
  end

  it 'returns a 400 level status code and body with explanatory description' do
    User.create(email: 'badexample@yoyo.com', password: 'no', password_confirmation: 'no')

    params = {email: "yeayea@ok.com",
      password: "password",
      password_confirmation: "password"}

    post '/api/v1/users', params: params

    expect(response.status).to eq(400)

    user_data = JSON.parse(response.body)

  end

end
