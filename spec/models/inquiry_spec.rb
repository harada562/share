require 'rails_helper'

RSpec.describe Inquiry, type: :model do
  context "データが正しく保存される" do
    before do
    	# customer作成
		@customer = Customer.new
		@customer.nick_name = "test"
		@customer.email = "test@test"
		@customer.password = "qqqqqq"
		@customer.save
    	# inquiry
		@inquiry = Inquiry.new
		@inquiry.title = "test"
		@inquiry.body = "body"
		@inquiry.customer_id = @customer.id
		@inquiry.save
    end
    it "全て入力してあるので保存される" do
      expect(@inquiry).to be_valid
    end
  end

  context "データが保存されない" do
    before do
    	# inquiry
		@inquiry = Inquiry.new
		@inquiry.title = ""
		@inquiry.body = ""
		@inquiry.customer_id = ""
		@inquiry.save
    end
    it "空白NGがあるので保存されない" do
      expect(@inquiry).to be_invalid
      expect(@inquiry.errors[:title]).to include("を入力してください")
      expect(@inquiry.errors[:body]).to include("を入力してください")
      expect(@inquiry.errors[:customer_id]).to include("を入力してください")
    end
  end
end
