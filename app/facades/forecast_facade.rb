class ForecastFacade

  def initialize(params_location)
    @params_location = params_location
  end


  def coordinate
    coordinate ||= CoordinateService.new(@params_location)
  end

  private

  

end
