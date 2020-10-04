require 'rails_helper'

RSpec.describe "Public::Inquiries", type: :request do
	let(:customer) { create(:customer) }
	let(:customer_params) { attributes_for(:customer) }
	let(:inquiry) { create(:inquiry) }

	describe 'お問い合わせ一覧' do
		before do
			# ActionMailer::Base.deliveries.clear
			# ログイン状態を作成する
			post customer_registration_path, params: { customer: customer_params }
	    end
		it "正しい画面に遷移する" do
			get public_inquiries_path
			expect(response).to have_http_status "200"
		end
		it "一覧が表示される" do
			get public_inquiries_path
			expect(response.body).to include("お問い合わせ")
		end
	end
end
