class PlaceRent < ActiveRecord::Base
  validates :start_date, :end_date, :parking, :car, presence: true
  belongs_to :parking
  belongs_to :car
end
