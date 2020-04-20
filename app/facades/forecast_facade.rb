class ForecastFacade

  def initialize(params_location)
    @params_location = params_location
  end

  def weather_info
    weather.data
  end

  private

  def coordinate
    coordinate ||= CoordinateService.new(@params_location)
  end

  def weather
    weather ||= WeatherDataService.new(coordinate.latitude, coordinate.longitude)
  end

end
