require 'rails_helper'

RSpec.describe "System::GroupsCustomers", type: :request do
  describe "グループ" do
  	before do
  		@customer = create(:customer)
      	visit new_customer_session_path
      	fill_in "customer[nick_name]", with: @customer.nick_name
	    fill_in "customer[password]", with: @customer.password
	    click_button "ログイン"
	    @group = create(:group)
	    @group2 = create(:group, is_closed: "ture", key_word: "合言葉")
    end

    it "グループ加入" do
    	visit public_group_path(@group.id)
    	click_button "グループ加入"
    	# 表示の確認
    	expect(page).to have_content "グループに加入しました"
    	expect(page).to have_content @group.name
    end

    it "グループを抜ける" do
    	visit public_group_path(@group.id)
    	click_button "グループ加入"
    	visit menbers_public_groups_customer_path(@group.id)
    	click_link "このグループを抜ける"
    	expect(page).to_not have_content @group.name
    end
  end
end
