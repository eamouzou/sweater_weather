class RoadTrip

  def initialize(origin, destination)
    @origin = origin
    @destination = destination
    @get = arrival_forecast
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
    # duration = Time.at(travel_time_data[:value]).utc.strftime("%H:%M:%S")
    weather_info = WeatherDataService.new(destination_coordinates.latitude, @destination_coordinates.longitude).data
    weather_info[:current][:temp].to_s + "°, " + weather_info[:current][:weather][0][:description].titleize
  end

end
