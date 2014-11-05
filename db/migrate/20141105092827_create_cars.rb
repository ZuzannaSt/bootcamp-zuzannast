class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :model
      t.string :registration_number
      t.integer :owner_id

      t.timestamps
    end
  end
end
