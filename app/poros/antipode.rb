class Antipode
  def initialize(data)
    @location_name = data[:location_name]
    @forecast_data = data[:forecast]
    @search_location = data[:search_location]
  end

  def id
    Time.now.strftime("%d/%m/%Y %H:%M")
  end

  def location_name
    @location_name
  end

  def forecast
    @forecast_data
  end

  def search_location
    @search_location
  end
end
