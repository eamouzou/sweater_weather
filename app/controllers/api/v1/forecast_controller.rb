class Api::V1::ForecastController < ApplicationController

  def index
    forecast_info = ForecastFacade.new(params[:location])
    render json: ForecastSerializer.new(forecast_info)
  end

end
