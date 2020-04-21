class Api::V1::RoadTripController < ApplicationController

  def create
    user = User.find_by(api_key: trip_params[:api_key])
    render_options(user)
  end

  private

  def trip_params
    params.permit(:origin, :destination, :api_key)
  end

  def render_options(user)
    render_road_trip if user
    render json: {failed: 'Unsuccessful request; please input proper credentials.'}, status: 401 if !user
  end

  def render_road_trip
    road_trip = RoadTrip.new(trip_params[:origin], trip_params[:destination])
    render json: RoadTripSerializer.new(road_trip), status: 200
  end

end
