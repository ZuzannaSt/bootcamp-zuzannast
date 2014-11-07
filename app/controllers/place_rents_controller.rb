class PlaceRentsController < ApplicationController
  def index
    @places = PlaceRent.all
  end

  def show
    @place = PlaceRent.find(params[:id])
  end

  def new
    @place = PlaceRent.new
    @cars = current_person.cars
  end

  def create
    @place = Parking.new(place_rent_params)

    if @place.save
      redirect_to @place, notice: 'Place was successfully rented.'
    else
      render action: 'new'
    end
  end

  private
  def place_rent_params
    params.require(:place_rent).permit(:start_date, :end_date) 
  end
end
