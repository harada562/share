require 'rails_helper'

RSpec.describe GroupsCustomer, type: :model do
  context "データが正しく保存される" do
    before do
    	# customer作成
		@customer = Customer.new
		@customer.nick_name = "test"
		@customer.email = "test@test"
		@customer.password = "qqqqqq"
		@customer.save
		# gorup作成
		@group = Group.new
		@group.name = "Hello"
		@group.save
		# gorup_customer
		@group_customer = GroupsCustomer.new
		@group_customer.group_id = @group.id
		@group_customer.customer_id = @customer.id
		@group_customer.is_admin = "true"
		@group_customer.save
    end
    it "全て入力してあるので保存される" do
      expect(@group_customer).to be_valid
    end
  end
end
