require 'rails_helper'

RSpec.describe 'Road Trip Request' do
  it "returns road trip data when provided with valid api key", :vcr do
    User.create(email: "yeayea@ok.com", password: "password",
      password_confirmation: "password", api_key: "jgn983hy48thw9begh98h4539h4")

    params = {"origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": "jgn983hy48thw9begh98h4539h4"}

    post "/api/v1/road_trip", params: params

    road_trip = JSON.parse(response.body)

    expect(response).to be_successful

    expected_keys = ['origin', 'destination', 'travel_time', 'arrival_forecast']

    expect(road_trip['data']['attributes'].keys).to eq(expected_keys)
  end

  it "returns 401 unauthorized  when provided no or an incorrect API key", :vcr do
    User.create(email: "yeayea@ok.com", password: "password",
      password_confirmation: "password", api_key: "jgn983hy48thw9begh98h4539h4")

    params = {"origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": " "}

    post "/api/v1/road_trip", params: params

    expect(response.status).to eq(401)

    road_trip = JSON.parse(response.body)

    expect(road_trip['failed']).to eq("Unsuccessful request; please input proper credentials.")
  end
end
