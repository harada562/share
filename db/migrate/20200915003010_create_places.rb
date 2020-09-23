class CreatePlaces < ActiveRecord::Migration[5.2]
	def change
		create_table :places do |t|
			t.integer :genre_id
			t.integer :customer_id, null: false
			t.integer :group_id
			t.string :place_name, null: false
			t.string :address, null: false
			t.string :image_id
			t.string :namber
			t.string :open_time
			t.string :close_time
			t.string :place_url
			t.integer :budget
			t.float :latitude
			t.float :longitude
			t.timestamps
		end
	end
end
