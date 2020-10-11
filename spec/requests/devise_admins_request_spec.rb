# require 'rails_helper'

# RSpec.describe "DeviseAdmins", type: :request do
#   # adminの作成
#   let(:admin) { create(:admin) }
#   # adminの正しいパロメータ
#   let(:admin_params) { attributes_for(:admin) }
#   # adminの正しくないパロメータ
#   let(:invalid_admin_params) { attributes_for(:admin, email: "") }

#   describe 'POST #create' do
#     before do
#       ActionMailer::Base.deliveries.clear
#     end

#     context 'パラメータが妥当な場合' do
#       it 'リクエストが成功すること' do
#         post admin_registration_path, params: { admin: admin_params }
#         expect(response.status).to eq 302
#       end

#       it 'リダイレクトされること' do
#         post admin_registration_path, params: { admin: admin_params }
#         expect(response).to redirect_to admin_inquiries_path
#       end
#     end

#     context 'パラメータが不正な場合' do
#       it 'リクエストが成功すること' do
#         post admin_registration_path, params: { admin: invalid_admin_params }
#         expect(response.status).to eq 200
#       end

#       it '認証メールが送信されないこと' do
#         post admin_registration_path, params: { admin: invalid_admin_params }
#         expect(ActionMailer::Base.deliveries.size).to eq 0
#       end
#     end
#   end
# end
