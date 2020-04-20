class ForecastFacade

  def initialize(params_location)
    @params_location = params_location
  end

  def weather_info
    weather_data.weather_info
  end

  private

  def coordinate
    coordinate ||= CoordinateService.new(@params_location)
  end

  def weather_data
    weather_data ||= WeatherDataService.new(coordinate.latitude, coordinate.longitude)
  end

end
