class RemoveImageIdFromPlaces < ActiveRecord::Migration[5.2]
  def change
    remove_column :places, :image_id, :string
  end
end
