require 'rails_helper'

RSpec.describe 'User Login' do
  it 'returns user api key if login request is successful' do
    user = User.create(email: 'example@yoyo.com', password: 'yes', password_confirmation: 'yes')

    params = {email: "example@yoyo.com", password: "yes"}
    post '/api/v1/sessions', params: params

    expect(response).to be_successful
    expect(response.status).to eq(200)

    user_data = JSON.parse(response.body)
    expected_keys = ['email', 'api_key']

    expect(user_data['data']['type']).to eq("user")
    expect(user_data['data']['attributes'].keys).to eq(expected_keys)
    expect(user_data['data']['attributes']['api_key']).to eq(user.api_key)
  end

  it 'returns a 400 level status code and fail message if credentials are bad' do
    user = User.create(email: 'example@yoyo.com', password: 'yes', password_confirmation: 'yes')

    params = {email: "example@yoyo.com", password: "yesno"}
    post '/api/v1/sessions', params: params

    expect(response.status).to eq(400)

    user_data = JSON.parse(response.body)

    expect(user_data['failed']).to eq("Unsuccessful, bad credentials.")
  end

  it 'returns a 400 level status code and fail message if credentials are bad' do
    user = User.create(email: 'example@yoyo.com', password: 'yes', password_confirmation: 'yes')

    params = {email: "", password: "yes"}
    post '/api/v1/sessions', params: params

    expect(response.status).to eq(400)

    user_data = JSON.parse(response.body)

    expect(user_data['failed']).to eq("Unsuccessful, bad credentials.")
  end

end
