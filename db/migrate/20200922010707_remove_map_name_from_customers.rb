class RemoveMapNameFromCustomers < ActiveRecord::Migration[5.2]
  def change
    remove_column :customers, :map_name, :string
  end
end
