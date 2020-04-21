class AntipodeService

  def initialize(search_latitude, search_longitude)
    @search_latitude = search_latitude
    @search_longitude = search_longitude
  end

  def latitude
    @antipode_memoized ||= antipode_json
    @antipode_memoized[:data][:attributes][:lat]
  end

  def longitude
    @antipode_memoized ||= antipode_json
    @antipode_memoized[:data][:attributes][:long]
  end

  private

  def antipode_json
    response = antipode_conn.get('/api/v1/antipodes') do |request|
      request.params[:lat] = @search_latitude
      request.params[:long] = @search_longitude
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def antipode_conn
    Faraday.new(url: 'http://amypode.herokuapp.com') do |f|
      f.adapter Faraday.default_adapter
      f.headers[:api_key] = ENV['AMYPODE_API_KEY']
    end
  end

end
