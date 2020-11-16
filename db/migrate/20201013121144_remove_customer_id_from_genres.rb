class RemoveCustomerIdFromGenres < ActiveRecord::Migration[5.2]
  def change
    remove_column :genres, :customer_id, :string
  end
end
