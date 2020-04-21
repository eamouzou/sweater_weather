class Forecast
  def initialize(weather_info)
    @weather_info = weather_info
  end

  def id
    Time.now.strftime("%d/%m/%Y %H:%M")
  end

  def latitude
    @weather_info[:lat]
  end

  def longitude
    @weather_info[:lon]
  end

  def timezone
    @weather_info[:timezone]
  end

  def current
    @weather_info[:current]
  end

  def hourly
    @weather_info[:hourly]
  end

  def daily
    @weather_info[:daily]
  end

  def summary
    @weather_info[:current][:weather][0][:main]
  end

  def current_temperature
    @weather_info[:current][:temp]
  end
end
