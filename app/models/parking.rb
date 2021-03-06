class Parking < ActiveRecord::Base
  before_destroy :set_end_date
  validates :places, presence: true
  validates :hour_price, :day_price, presence: true, numericality: true
  validates :kind, inclusion: { in: %w(outdoor indoor private street) }

  belongs_to :address
  belongs_to :owner, class_name: "Person"
  has_many :place_rents

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :owner

  scope :public_parkings, -> { where( kind: ["street", "indoor", "outdoor"] ) }
  scope :private_parkings, -> { where( kind: "private" ) }
  scope :day_price_between, -> (min_day_price, max_day_price) { where( "day_price > ? and day_price < ?", min_day_price, max_day_price ) }
  scope :hour_price_between, -> (min_hour_price, max_hour_price) { where( "hour_price > ? and hour_price < ?", min_hour_price, max_hour_price ) }
  scope :in_city, -> (city) { where( "city = ?", city ).joins(:address) }

  def set_end_date
    place_rents.ongoing.each do |place|
       place.finish
    end
  end

  def self.search(params)
    parkings = Parking.all
    city = params[:city]
    public_parking = params[:public_parking]
    private_parking = params[:private_parking]
    min_hour_price = params[:min_hour_price]
    max_hour_price = params[:max_hour_price]    
    min_day_price = params[:min_day_price]
    max_day_price = params[:max_day_price]
    
    parkings = parkings.in_city(city) if city.present?
   
   if public_parking.blank? && private_parking.present?
      parkings = parkings.private_parkings
    elsif private_parking.blank? && public_parking.present?
      parkings = parkings.public_parkings
    elsif public_parking.present? && private_parking.present?
      parkings = parkings
    end
    
    if min_hour_price.blank? && max_hour_price.present?
      min_hour_price = 0  
      parkings = parkings.hour_price_between(min_hour_price, max_hour_price)
    elsif min_hour_price.present? && max_hour_price.present?  
      parkings = parkings.hour_price_between(min_hour_price, max_hour_price)
    end
    
    if min_day_price.blank? && max_day_price.present?
      min_day_price = 0
      parkings = parkings.day_price_between(min_day_price, max_day_price)
    elsif min_day_price.present? && max_day_price.present?  
      parkings = parkings.day_price_between(min_day_price, max_day_price)
    end

    parkings
  end
end
