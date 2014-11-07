class PlaceRent < ActiveRecord::Base
	validates :start_date, :end_date, :parking_id, :car_id, presence: true
	belongs_to :parking
	belongs_to :car
	has_many :people

  accepts_nested_attributes_for :car
  accepts_nested_attributes_for :parking
end
