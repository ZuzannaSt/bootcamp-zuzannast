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

  scope :public_parkings, -> { where( kind: "public" ) }
  scope :private_parkings, -> { where( kind: "private" ) }
  scope :day_price_between, -> (lower_limit, upper_limit) { where( "day_price > ? and day_price < ?", lower_limit, upper_limit ) }
  scope :hour_price_between, -> (lower_limit, upper_limit) { where( "hour_price > ? and hour_price < ?", lower_limit, upper_limit ) }
  scope :in_city, -> (city) { where( "city = ?", city ).joins(:address) }

  def set_end_date
    end_date = Time.now
  end
end
