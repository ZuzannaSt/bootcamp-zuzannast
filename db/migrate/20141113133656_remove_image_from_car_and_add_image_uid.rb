class RemoveImageFromCarAndAddImageUid < ActiveRecord::Migration
  def change
    remove_column :cars, :image
    add_column :cars, :image_uid, :string
  end
end
