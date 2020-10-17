class CreatePlaceImages < ActiveRecord::Migration[5.2]
  def change
    create_table :place_images do |t|
		t.string :image_id, null: false
		t.integer :place_id, null: false
		t.timestamps
		t.index ["place_id"], name: "index_place_images_on_place_id"
    end
  end
end
