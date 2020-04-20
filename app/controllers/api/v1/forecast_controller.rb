class Api::V1::ForecastController < ApplicationController

  def index
    forecast_info = ForecastFacade.new(params[:location]).weather_info
    render json: ForecastSerializer.new(Forecast.new(forecast_info))
  end

end
