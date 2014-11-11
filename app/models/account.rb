class Account < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  
  belongs_to :person
end
