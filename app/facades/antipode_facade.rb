class AntipodeFacade
  def initialize(search_location)
    @search_location = search_location
    @get = antipode_forecast
  end

  private

  def search_coordinates
    coordinates ||= CoordinateService.new(@search_location)
  end

  def antipode_coordinates
    coordinates ||= AntipodeService.new(search_coordinates.latitude, search_coordinates.longitude)
  end

  def antipode_forecast
    weather_info = WeatherDataService.new(antipode_coordinates.latitude, antipode_coordinates.longitude).data
    antipode_forecast = Forecast.new(weather_info)
    require "pry"; binding.pry
  end

end
