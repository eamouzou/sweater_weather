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

    expect(user_data['data']['type']).to eq("user")
    expect(user_data['data']['attributes'].keys).to eq(expected_keys)
    expect(user_data['data']['attributes']['api_key']).to eq(user.api_key)
  end

  it 'returns a 400 level status code and fail message if email is already used' do
    User.create(email: 'badexample@yoyo.com', password: 'no', password_confirmation: 'no')

    params = {email: "badexample@yoyo.com",
      password: "password",
      password_confirmation: "password"}

    post '/api/v1/users', params: params

    expect(response.status).to eq(400)

    user_data = JSON.parse(response.body)

    expect(user_data['failed']).to eq("Email has already been taken")
  end

  it 'returns a 400 level status code and fail message if passwords do not match' do
    params = {email: "badexample@yoyo.com",
      password: "no",
      password_confirmation: "password"}

    post '/api/v1/users', params: params

    expect(response.status).to eq(400)

    user_data = JSON.parse(response.body)

    expect(user_data['failed']).to eq("Password confirmation doesn't match Password")
  end

  it 'returns a 400 level status code and fail message if field is missing' do
    params = {email: "",
      password: "",
      password_confirmation: "password"}

    post '/api/v1/users', params: params

    expect(response.status).to eq(400)

    user_data = JSON.parse(response.body)

    expect(user_data['failed']).to eq("Email can't be blank, Password digest can't be blank, and Password can't be blank")
  end

end
