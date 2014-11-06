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
        format.html { redirect_to @parking }
      else
        format.html { render action: 'new' }
    end
end
  end

  def update
   respond_to do |format|
      if @parking.update(parking_params)
        format.html { redirect_to @parking }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  private
    def parking_params
      params.require(:parking).permit(:places, :kind, :hour_price, :day_price) 
    end

end
