class CreateGroupsCustomers < ActiveRecord::Migration[5.2]
	def change
		create_table :groups_customers do |t|
			t.integer :customer_id, null: false
			t.integer :group_id, null: false
			t.boolean :is_admin, default: false, null: false
			t.timestamps
		end
	end
end
