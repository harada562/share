class CreateGroups < ActiveRecord::Migration[5.2]
	def change
		create_table :groups do |t|
			t.string :name, null: false
			t.string :key_word
			t.boolean :is_closed, default: false, null: false
			t.timestamps
		end
		add_index :groups, :name, unique: true
		add_index :groups, :key_word, unique: true
	end
end
