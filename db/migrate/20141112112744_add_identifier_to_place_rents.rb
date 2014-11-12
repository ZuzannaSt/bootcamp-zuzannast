class AddIdentifierToPlaceRents < ActiveRecord::Migration
  def change
    add_column :place_rents, :identifier, :string
    add_index :place_rents, :identifier, unique: true
  end
end
