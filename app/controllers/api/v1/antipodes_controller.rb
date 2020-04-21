class Api::V1::AntipodesController < ApplicationController

  def show
    antipode_info = AntipodeFacade.new(params[:location]).antipode_info
    render json: AntipodeSerializer.new(Antipode.new(antipode_info))
  end

end
