class AddCustomerIdToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :customer_id, :intege,
    add_column :groups, :null, :string
    add_column :groups, :false, :string
  end
end
