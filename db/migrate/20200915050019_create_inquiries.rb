class CreateInquiries < ActiveRecord::Migration[5.2]
	def change
		create_table :inquiries do |t|
			t.integer :customer_id, null: false
			t.string :title, null: false
			t.text :body, null: false
			t.integer :status, default: 0, null: false
			t.timestamps
		end
	end
end
