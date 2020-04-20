class ForecastFacade
  attr_reader :location

  def initialize(params_location)
    @params_location = params_location
    @location = get_long_and_lat
  end

  def get_long_and_lat
    get_geocode_json[:results].first[:geometry][:location]
  end

  private

  def get_geocode_json
    response = get_geocode_conn.get('/maps/api/geocode/json') do |g|
      g.params[:address] = "#{@params_location}"
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_geocode_conn
    Faraday.new(url: 'https://maps.googleapis.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV['GEOCODING_API_KEY']
    end
  end

end
