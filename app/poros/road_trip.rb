class RoadTrip

  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def id
    Time.now.strftime("%d/%m/%Y %H:%M")
  end

  def origin
    @origin
  end

  def destination
    @destination
  end

  def travel_time_data
    DirectionsService.new(@origin, @destination).time
  end

  def travel_time
    travel_time_data[:text]
  end

  def destination_coordinates
    @destination_coordinates ||= CoordinateService.new(@destination)
  end

  def arrival_forecast
    weather_info = WeatherDataService.new(destination_coordinates.latitude, @destination_coordinates.longitude).data
    time_to_hour = (travel_time_data[:value] / 60.0 / 60.0).round
    weather_info[:hourly][time_to_hour - 1][:temp].to_s + "°, " + weather_info[:hourly][time_to_hour - 1][:weather][0][:description].titleize
  end

end
