class ParkingsController < ApplicationController
  before_filter :parking, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to parkings_path, alert: t(:parking_not_found)
  end

  def index
    @parkings = Parking.search(params).order(:id).paginate(:page => params[:page], :per_page => 5)
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
      redirect_to @parking, notice: t(:parking_created)
    else
      render action: 'new'
    end
  end

  def update
    if @parking.update(parking_params)
      redirect_to @parking, notice: t(:parking_updated)
    else
      render action: 'edit'
    end
  end

  def destroy
    @parking.destroy
    redirect_to parkings_url, notice: t(:parking_destroyed)
  end

  private
    def parking_params
      params.require(:parking).permit(:places, :kind, :hour_price, :day_price, :owner, address_attributes: [ :zip_code, :street, :city ])
    end

    def parking
      @parking = Parking.find(params[:id])
    end
end
