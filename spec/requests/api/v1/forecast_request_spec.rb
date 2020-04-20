require 'rails_helper'

RSpec.describe 'Retrieve Weather Forecast', :vcr do
  it 'returns the forecast for a city' do
    city = 'aurora,co'

    get "/api/v1/forecast?location=#{city}"

    expect(response).to be_successful

    forecast_response = JSON.parse(response.body, symbolize_names: true)
    forecast_data = forecast_response[:data][:attributes]

    expected_keys = [:id, :latitude, :longitude, :timezone, :current, :hourly, :daily]

    expect(forecast_data.keys).to eq(expected_keys)
  end
end
