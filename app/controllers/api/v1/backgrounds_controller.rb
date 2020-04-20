class Api::V1::BackgroundsController < ApplicationController

  def index
    background_info = BackgroundService.new(params[:location])
    render json: BackgroundSerializer.new(background_info)
  end

end
