require 'rails_helper'

# gorups_controllerのテストを定義
RSpec.describe "Public::Groups", type: :request do
  # テストの大枠を定義
  describe '新規グループ作成のテスト' do
    # ここで使用するものを準備
    # グループを作成
    let!(:group) { create(:group, name: 'hoge') }
    # ログイン状態の前処理
    let(:customer) { create(:customer) }
    let(:customer_params) { attributes_for(:customer) }
    # 小枠

    describe 'グループ作成' do
      # 前処理
      before do
        # ActionMailer::Base.deliveries.clear
        # ログイン状態を作成
        post customer_registration_path, params: { customer: customer_params }
      end
      # discribeの小枠

      context 'グループ作成' do
        it 'グループ作成に正しく遷移する' do
          get new_public_group_path
          expect(response).to have_http_status "200"
        end
        it "表示の確認" do
          get new_public_group_path
          expect(response.body).to include("グループ作成")
        end
      end
    end

    describe 'グループ詳細' do
      # 前処理
      before do
        ActionMailer::Base.deliveries.clear
        # ログイン状態を作成
        post customer_registration_path, params: { customer: customer_params }
        get public_group_path(group)
      end
      # discribeの小枠

      context '表示の確認' do
        it 'グループ詳細が表示されているか' do
          expect(response).to have_http_status "200"
        end
      end
    end
  end
end
