require 'rails_helper'

RSpec.describe "Devisecustomers", type: :request do
  let(:customer) { create(:customer) }
  let(:customer_params) { attributes_for(:customer) }
  let(:invalid_customer_params) { attributes_for(:customer, email: "") }

  describe 'POST #create' do
    before do
      ActionMailer::Base.deliveries.clear
    end

    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post customer_registration_path, params: { customer: customer_params }
        expect(response.status).to eq 302
      end

      it 'createが成功すること' do
        expect do
          post customer_registration_path, params: { customer: customer_params }
        end.to change(Customer, :count).by 1
      end

      it 'リダイレクトされること' do
        post customer_registration_path, params: { customer: customer_params }
        expect(response).to redirect_to home_top_select_path
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post customer_registration_path, params: { customer: invalid_customer_params }
        expect(response.status).to eq 200
      end

      it 'createが失敗すること' do
        expect do
          post customer_registration_path, params: { customer: invalid_customer_params }
        end.not_to change(Customer, :count)
      end

      it 'エラーが表示されること' do
        post customer_registration_path, params: { customer: invalid_customer_params }
        expect(response.body).to include "メールアドレスを入力してください"
      end
    end
  end
end
