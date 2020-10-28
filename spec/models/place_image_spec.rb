require 'rails_helper'

RSpec.describe PlaceImage, type: :model do
	context "データが正しく保存される" do
		before do
			# customer作成
    		@customer = create(:customer)
			# place 作成
			@place = create(:place)
		end
		it "全て入力してあるので保存される" do
			# place_imagesの作成
			@place_image = PlaceImage.new
			@place_image.image_id = "jjj.png"
			@place_image.place_id = @place.id
			@place_image.save
			expect(@place_image).to be_valid
		end
	end
	context "データが保存されない" do
		before do
			# customer作成
    		@customer = create(:customer)
			# place 作成
			@place = create(:place)
		end
		it "空白があるので保存されない" do
			# place_imagesの作成
			@place_image = PlaceImage.new
			@place_image.image_id = "ll.png"
			@place_image.place_id = ""
			@place_image.save
			expect(@place_image.errors[:place_id]).to include("を入力してください")
		end
	end
end
