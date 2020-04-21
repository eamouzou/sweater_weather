class AntipodeFacade
  def initialize(search_location)
    @search_location = search_location
  end

  def antipode_info
    {location_name: get_location_name,
      forecast: {"summary": antipode_forecast.summary,
        "current_temperature": antipode_forecast.current_temperature},
      search_location: search_coordinates.location}
  end

  private

  def search_coordinates
    @search_coordinates ||= CoordinateService.new(@search_location)
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
