class AntipodeFacade
  def initialize(search_location)
    @search_location = search_location
  end

  def antipode_info
    # make higher level methods to make it easier to follow the process
    # or write it out step by step, line by line to show that there are separate steps of this process
    #since order matters, it's best to use a hash with named expected_attr_keys
    #if the purpose of the order is to identify something, you're using the array order as an identifier; might as well use a hash
    {location_name: get_location_name,
      forecast: {"summary": antipode_forecast.summary,
        "current_temperature": antipode_forecast.current_temperature},
      search_location: search_coordinates.location}
  end

  private

  def search_coordinates
    @search_coordinates ||= CoordinateService.new(@search_location)
    # @coordinates = @coordinates || CoordinateService.new(@search_location)
  end

  def antipode_coordinates
    @antipode_coordinates ||= AntipodeService.new(search_coordinates.latitude, search_coordinates.longitude)
  end

  def antipode_forecast
    weather_info = WeatherDataService.new(antipode_coordinates.latitude, antipode_coordinates.longitude).data
    antipode_forecast = Forecast.new(weather_info)
  end

  def get_location_name
    lat_long = "#{antipode_coordinates.latitude}, #{antipode_coordinates.longitude}"
    search_coordinates.location_name(lat_long)
  end

end
