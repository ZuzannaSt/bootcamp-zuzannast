class Car < ActiveRecord::Base
  validates :model, :registration_number, :owner, presence: true

  belongs_to :owner, class_name: "Person"
  has_many :place_rents

  def to_param
    "#{id}-#{model.parameterize}"
  end
end
