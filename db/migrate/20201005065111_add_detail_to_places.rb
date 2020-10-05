class AddDetailToPlaces < ActiveRecord::Migration[5.2]
  def change
    add_column :places, :detail, :text
  end
end
