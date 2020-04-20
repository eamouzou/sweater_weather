class CoordinateService

  def initialize(params_location)
    @params_location = params_location
    @location ||= coordinate_json[:results].first[:formatted_address]
    @longitude ||= coordinate_json[:results].first[:geometry][:location][:lng]
    @latitude ||= coordinate_json[:results].first[:geometry][:location][:lat]
  end

  def location
    coordinate_json[:results].first[:formatted_address]
  end

  def longitude
    coordinate_json[:results].first[:geometry][:location][:lng]
  end

  def latitude
    coordinate_json[:results].first[:geometry][:location][:lat]
  end

  private

  def coordinate_json
    response = coordinate_conn.get('/maps/api/geocode/json') do |request|
      request.params[:address] = "#{@params_location}"
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def coordinate_conn
    Faraday.new(url: 'https://maps.googleapis.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV['GEOCODING_API_KEY']
    end
  end

end
