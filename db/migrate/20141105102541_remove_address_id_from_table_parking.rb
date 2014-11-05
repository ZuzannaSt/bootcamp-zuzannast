class RemoveAddressIdFromTableParking < ActiveRecord::Migration
  def change
  	remove_column :parkings, :addres_id, :integer, {}
  end
end
