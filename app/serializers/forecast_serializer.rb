class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :latitude, :longitude, :timezone, :current, :hourly, :daily
end
