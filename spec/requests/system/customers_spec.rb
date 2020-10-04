require 'rails_helper'

RSpec.describe "System::Customers", type: :request do
  describe "移動" do
  	before do
      visit new_customer_session_path
    end
    it "works! (now write some real specs)" do
      expect(page).to have_content("新規登録が済んでない方")
    end

    it '新規登録画面に移動' do
    	click_link '新規登録が済んでない方'
    	expect(page).to have_content("新規登録")
    end
  end
end
