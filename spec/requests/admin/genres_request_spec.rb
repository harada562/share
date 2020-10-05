require 'rails_helper'

RSpec.describe "Admin::Genres", type: :request do
  # ユーザーを作成する
  let(:admin) { create(:admin) }
  # ハッシュとして使えるパラメータadmin_paramsを生成しておく
  let(:admin_params) { attributes_for(:admin) }
  # ハッシュとして使えないパラメータadmin_paramsを生成しておく
  let(:invalid_admin_params) { attributes_for(:admin, email: "") }

  describe 'genreコントローラー' do
    before do
      ActionMailer::Base.deliveries.clear
      # ログイン状態を作成する
      post admin_registration_path, params: { admin: admin_params }
    end

    context 'ログイン後' do
      it 'post画面にいく' do
        get admin_genres_path
        expect(response).to have_http_status "200"
      end
      it 'タイトルが正しく表示されていること' do
        get admin_genres_path
        expect(response.body).to include("スポット一覧")
        expect(response.body).to include("全てのジャンル")
      end
    end
  end
end
