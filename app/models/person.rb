class Person < ActiveRecord::Base
	validates :first_name

	has_many :parkings
	has_many :cars
end
