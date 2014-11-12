class PlaceRentsController < ApplicationController
  before_action :authenticate_person
  
  def index
    @places = PlaceRent.all.order(:start_date)
  end

  def show
    @place = PlaceRent.find_by(identifier: params[:id])
  end

  def new
    @place = PlaceRent.new
    @parking = Parking.find(params[:parking_id])
  end

  def create
    @place = Parking.find(params[:parking_id]).place_rents.build(place_rent_params)
    
    if @place.save
      redirect_to @place, notice: 'Place was successfully rented.'
    else
      render action: 'new'
    end
  end

  private
  def place_rent_params
    params.require(:place_rent).permit(:start_date, :end_date, :car_id, :identifier) 
  end
end
