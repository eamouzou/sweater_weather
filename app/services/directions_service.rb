class DirectionsService

  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def time
    @directions_json ||= directions_json
    @directions_json[:routes][0][:legs][0][:duration]
  end

  private

  def directions_json
    response = directions_conn.get
    directions_json ||= JSON.parse(response.body, symbolize_names: true)
  end

  def directions_conn
    Faraday.new(url: 'https://maps.googleapis.com/maps/api/directions/json') do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV['GEOCODING_API_KEY']
      f.params[:origin] = @origin
      f.params[:destination] = @destination
    end
  end

end
