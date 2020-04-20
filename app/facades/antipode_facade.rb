class AntipodeFacade
  def initialize(search_location)
    @search_location = search_location
    @get = antipode_coordinates
  end

  private

  def search_coordinates
      coordinates ||= CoordinateService.new(@search_location)
  end

  def antipode_coordinates
    coordinates ||= AntipodeService.new(search_coordinates.latitude, search_coordinates.longitude)
    require "pry"; binding.pry
  end

end
