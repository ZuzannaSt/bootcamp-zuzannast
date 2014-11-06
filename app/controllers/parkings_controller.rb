class ParkingsController < ApplicationController

  def index
    @parkings = Parking.all
  end

  def show
    @parking = Parking.find(params[:id])
  end

  def new
    @parking = Parking.new
  end

  def edit
  end

  def create
    @parking = Parking.new(parking_params)

    respond_to do |format|
      if @parking.save
        format.html { redirect_to @parking, notice: 'parking was successfully created.' }
        format.json { render action: 'show', status: :created, location: @parking }
      else
        format.html { render action: 'new' }
        format.json { render json: @parking.errors, status: :unprocessable_entity }
    end
end
  end

  def update
    @parking = Parking.update(parking_params)
  end

  private
    def parking_params
      params.require(:parking).permit(:places, :kind, :hour_price, :day_price, :address_id, :owner_id) 
    end

end
