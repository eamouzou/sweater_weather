class CoordinateService

  def initialize(params_location)
    @params_location = params_location
    @location ||= coordinate_json[:results].first[:formatted_address]
  end

  def location
    @location
  end

  def longitude
    @coordinate_json ||= coordinate_json
    @coordinate_json[:results].first[:geometry][:location][:lng]
  end

  def latitude
    @coordinate_json[:results].first[:geometry][:location][:lat]
  end

  def location_name(lat_long)
    location_name_json(lat_long)[:results][1][:formatted_address]
  end

  private
  def location_name_json(lat_long)
    response = coordinate_conn.get('/maps/api/geocode/json') do |request|
      request.params[:latlng] = "#{lat_long}"
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def coordinate_json
    response = coordinate_conn.get('/maps/api/geocode/json') do |request|
      request.params[:address] = "#{@params_location}"
    end
    puts 'coordinate_json_api_call' #gives you a sense of how many times it is called
    @coordinate_json ||= JSON.parse(response.body, symbolize_names: true)
  end

  def coordinate_conn
    Faraday.new(url: 'https://maps.googleapis.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV['GEOCODING_API_KEY']
    end
  end

end
