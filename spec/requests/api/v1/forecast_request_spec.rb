require 'rails_helper'

RSpec.describe 'Retrieve Weather Forecast' do
  it 'returns the forecast for a city' do
    city = 'aurora,co'

    get "/api/v1/forecast?location=#{city}"

    expect(response).to be_successful

    forecast_response = JSON.parse(response.body, symbolize_names: true)
  end
end
