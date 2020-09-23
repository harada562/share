class RenameNamberColumnToPlaces < ActiveRecord::Migration[5.2]
  def change
  	rename_column :places, :namber, :number
  end
end
