require 'rails_helper'

RSpec.describe Customer, type: :model do
  context "データが正しく保存される" do
    before do
      @customer = Customer.new
      @customer.nick_name = "test"
      @customer.email = "test@test"
      @customer.password = "qqqqqq"
      @customer.save
    end

    it "全て入力してあるので保存される" do
      expect(@customer).to be_valid
    end
  end

  context "データが正しく保存されない" do
    before do
      @customer = Customer.new
      @customer.nick_name = ""
      @customer.email = ""
      @customer.password = ""
      @customer.save
    end

    it "nameが入力されていないので保存されない" do
      expect(@customer).to be_invalid
      expect(@customer.errors[:nick_name]).to include("は3文字以上で入力してください")
      expect(@customer.errors[:email]).to include("を入力してください")
      expect(@customer.errors[:password]).to include("を入力してください")
    end
  end
end
