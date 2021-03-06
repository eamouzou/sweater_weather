require 'rails_helper'

RSpec.describe 'Antipode API', :vcr do
  it "gets antipode attributes from location" do
    get '/api/v1/antipode?location=hongkong'

    expect(response).to be_successful

    antipode_response = JSON.parse(response.body, symbolize_names: true)

    antipode_attributes = antipode_response[:data][:attributes]
    expected_attr_keys = [:location_name, :forecast, :search_location]

    expect(antipode_response[:data][:id]).to be_truthy
    expect(antipode_response[:data][:type]).to eq('antipode')
    expect(antipode_attributes.keys).to eq(expected_attr_keys)
    expect(antipode_attributes[:search_location]).to eq('Hong Kong')
  end
end
