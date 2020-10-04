require 'rails_helper'

RSpec.describe "Public::Places", type: :request do
	let(:customer) { create(:customer) }
	let(:customer_params) { attributes_for(:customer) }

	let(:place) { create(:place) }

	describe 'placeコントローラー' do
		before do
	      # ActionMailer::Base.deliveries.clear
	      # ログイン状態を作成する
			post customer_registration_path, params: { customer: customer_params }
	    end
	    context 'ログイン後' do
			it '場所一覧画面にいく' do
				get public_places_path
				expect(response).to have_http_status "200"
			end
			it 'タイトルが正しく表示されていること' do
				get public_places_path
        		expect(response.body).to include("スポット一覧")
      		end
    	end
    	context '場所投稿画面' do
			it '場所投稿画面にいく' do
				get new_public_place_path
				expect(response).to have_http_status "200"
			end
			it 'タイトルが正しく表示されていること' do
				get new_public_place_path
        		expect(response.body).to include("スポット登録")
      	end
    	end
    	context '場所詳細画面' do
			it '場所詳細画面にいく' do
				get public_place_path(place)
				expect(response).to have_http_status "200"
			end
			it 'タイトルが正しく表示されていること' do
				get public_place_path(place)
				expect(response.body).to include("スポット詳細")
			end
    	end
	end
end
