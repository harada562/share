class AddCustomerIdToGenres < ActiveRecord::Migration[5.2]
  def change
    add_column :genres, :customer_id, :integer
  end
end
