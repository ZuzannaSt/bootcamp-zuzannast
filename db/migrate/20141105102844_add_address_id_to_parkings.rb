class AddAddressIdToParkings < ActiveRecord::Migration
  def change
  	add_column :parkings, :address_id, :integer
  end
end
