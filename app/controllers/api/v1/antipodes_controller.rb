class Api::V1::AntipodesController < ApplicationController

  def show
    antipode_info = AntipodeFacade.new(params[:location])
    render json: AntipodeSerializer.new(antipode_info)
  end

end
