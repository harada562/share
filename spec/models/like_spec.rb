require 'rails_helper'

RSpec.describe Like, type: :model do
  context "データが正しく保存される" do
    before do
		# customer の作成
		@customer = Customer.new
		@customer.nick_name = "test"
		@customer.email = "test@test"
		@customer.password = "qqqqqq"
		@customer.save
		# place 作成
		@place = Place.new
		@place.customer_id = @customer.id
		@place.place_name = "test"
		@place.address = "東京都"
    @place.save
		# like
		@like = Like.new
		@like.customer_id = @customer.id
		@like.place_id = @place.id
		@like.save
    end
    it "全て入力してあるので保存される" do
      expect(@like).to be_valid
    end
  end

  context "データが正しく保存されない" do
    before do
      @like = Like.new
      @like.customer_id = ""
      @like.place_id = ""
      @like.save
    end
    it "空白NGがあるので保存されない" do
      expect(@like).to be_invalid
      expect(@like.errors[:customer_id]).to include("を入力してください")
      expect(@like.errors[:place_id]).to include("を入力してください")
    end
  end
end
