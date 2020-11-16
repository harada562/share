class AddCustomerIdToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :customer_id, :intege
  end
end
