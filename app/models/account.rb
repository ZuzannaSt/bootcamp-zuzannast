class Account < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  has_secure_password validations: false
  validates :password, presence: true, confirmation: true

  belongs_to :person

  accepts_nested_attributes_for :person
end

