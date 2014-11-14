class Car < ActiveRecord::Base
  extend Dragonfly::Model
  extend Dragonfly::Model::Validations
  dragonfly_accessor :image
    
  validates :model, :registration_number, :owner, presence: true
  validates_size_of :image, maximum: 200.kilobytes
  validates_property :format, of: :image, in: ['jpeg', 'png', 'gif']

  belongs_to :owner, class_name: "Person"
  has_many :place_rents

  def to_param
    "#{id}-#{model.parameterize}"
  end
end
