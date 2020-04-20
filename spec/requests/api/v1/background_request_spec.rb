require 'rails_helper'

RSpec.describe 'Background Image', :vcr do
  it 'returns the url for a location specific ackground image' do
    city = 'aurora,co'

    get "/api/v1/backgrounds?location=#{city}"

    expect(response).to be_successful

    background_response = JSON.parse(response.body, symbolize_names: true)

    expect(background_response[:data][:attributes].keys.include?(:url)).to eq(true)
    expect(background_response[:data][:attributes][:url]).to be_truthy
  end
end
