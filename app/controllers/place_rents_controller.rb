class PlaceRentsController < ApplicationController
  def index
    @places = PlaceRent.all
  end

  def show
    @place = PlaceRent.find(params[:id])
  end

  private
  def place_rent_params
    params.require(:place_rent).permit(:start_date, :end_date) 
  end
end
