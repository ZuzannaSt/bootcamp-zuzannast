class ParkingsController < ApplicationController
before_filter :parking, only: [:show, :edit, :update, :destroy]

  def index
    @parkings = Parking.all
  end

  def show
  end

  def new
    @parking = Parking.new
    @parking.build_address
  end

  def edit
    @parking.build_address unless @parking.address 
  end

  def create
    @parking = Parking.new(parking_params)

    if @parking.save
        redirect_to @parking, notice: 'Parking was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @parking.update(parking_params)
        redirect_to @parking, notice: 'Parking was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @parking.destroy
    redirect_to parkings_url, notice: 'Parking was successfully destroyed'
  end

  private
    def parking_params
      params.require(:parking).permit(:places, :kind, :hour_price, :day_price, {:address_attributes => [ :zip_code, :street, :city ]}) 
    end

    def parking
      @parking = Parking.find(params[:id])
    end
end
