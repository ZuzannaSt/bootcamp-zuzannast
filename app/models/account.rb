class Account < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  has_secure_password
  validates :password, presence: true
  
  belongs_to :person
end

