class BackgroundService

  def initialize(params_location)
    @params_location = params_location.gsub(",", "+")
  end

  def id
    Time.now.strftime("%d/%m/%Y %H:%M")
  end

  def url
    background_json[:results][0][:urls][:full]
  end

  private

  def background_json
    response = background_conn.get("/search/photos") do |request|
      request.params[:page] = '1'
      request.params[:query] = "#{@params_location}"
      request.params[:per_page] = '1'
      request.params[:order_by] = 'relevant'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def background_conn
    Faraday.new(url: 'https://api.unsplash.com/') do |f|
      f.adapter Faraday.default_adapter
      f.params[:client_id] = ENV['UNSPLASH_ACCESS_KEY']
      f.headers['Accept-Version'] = 'v1'
    end
  end
end
