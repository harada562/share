class RemoveImageIdFromCustomers < ActiveRecord::Migration[5.2]
  def change
    remove_column :customers, :ImageId, :string
  end
end
