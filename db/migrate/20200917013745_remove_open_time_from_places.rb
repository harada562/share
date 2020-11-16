class RemoveOpenTimeFromPlaces < ActiveRecord::Migration[5.2]
  def change
    remove_column :places, :open_time, :string
  end
end
