require 'rails_helper'

RSpec.describe Place, type: :model do
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
    end

    it "全て入力してあるので保存される" do
      expect(@place).to be_valid
    end
  end

  context "データが正しく保存されない" do
    before do
      @place = Place.new
      @place.customer_id = ""
      @place.place_name = ""
      @place.address = ""
      @place.save
    end

    it "空白NGがあるので保存されない" do
      expect(@place).to be_invalid
      expect(@place.errors[:customer_id]).to include("を入力してください")
      expect(@place.errors[:place_name]).to include("を入力してください")
    end
    it "文字制限があるので保存されない" do
      expect(@place.errors[:address]).to include("は3文字以上で入力してください")
    end
  end
end
