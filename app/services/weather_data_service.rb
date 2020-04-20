class WeatherDataService
  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def data
    JSON.parse(weather_json.body, symbolize_names: true)
  end

  private

  def weather_json
    weather_conn.get("/data/2.5/onecall?lat=#{@latitude}&lon=#{@longitude}&appid=#{ENV['OPEN_WEATHER_API_KEY']}")
  end

  def weather_conn
    Faraday.new(url: 'https://api.openweathermap.org') do |f|
      f.adapter Faraday.default_adapter
      f.params["units"] = "imperial"
      f.params["timezone"] = "UTC -7"
    end
  end
end
