class RemoveCloseTimeFromPlaces < ActiveRecord::Migration[5.2]
  def change
    remove_column :places, :close_time, :string
  end
end
