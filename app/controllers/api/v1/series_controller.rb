# app/controllers/api/v1/series_controller.rb
class Api::V1::SeriesController < Api::V1::BaseController
  def index
    render json: Series.all
  end

  def show
    render json: Series.find(params[:id])
  end
end
