class PlaceRent < ActiveRecord::Base
  before_save :calculate_price
  before_save :set_identifier
  validates :start_date, :end_date, :parking, :car, presence: true
  belongs_to :parking
  belongs_to :car

  scope :ongoing, -> { where("end_date > ?", Time.now )}

  def to_param
    identifier
  end  

  def finish
    update_attribute(:end_date,Time.now)
  end

  def time_spent
    (end_date - start_date).to_i / 3600
  end

  def days_spent
    time_spent / 24
  end

  def hours_spent
    time_spent % 24    
  end

  def calculate_price
    self.price = parking.day_price * days_spent + parking.hour_price * hours_spent 
  end

  private
  def set_identifier
    self.identifier ||= SecureRandom.urlsafe_base64
  end
end
