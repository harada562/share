require 'rails_helper'

RSpec.describe "Admin::Genres", type: :request do
	describe 'ジャンル投稿、一覧' do
    context "新規投稿、一覧ページが正しく表示される" do
      before do
        get admin_genres_path
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 302
      end
    end
  end
end
