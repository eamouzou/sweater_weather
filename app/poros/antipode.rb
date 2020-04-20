class Antipode
  def initialize(data)
    @location_name = data[0]
    @forecast_data = data[1]
    @search_location = data[2]
  end

  def id
    Time.now.strftime("%d/%m/%Y %H:%M")
  end

  def location_name
    @location_name
  end

  def forecast
    {"summary": "#{@forecast_data[0]}", "current_temperature": "#{@forecast_data[1]}"}
  end

  def search_location
    @search_location
  end
end
