require 'rails_helper'

RSpec.describe "PlaceImages", type: :request do
  scenario "場所の作成" do
    # customer作成
    @customer = create(:customer)
    # genre作成
    @genre = create(:genre)
    # binding.pry
    # ログイン
    visit new_customer_session_path
    fill_in "customer[nick_name]", with: @customer.nick_name
    fill_in "customer[password]", with: @customer.password
    click_button "ログイン"
    # 場所作成画面に遷移
    visit new_public_place_path
    # 必須項目を入力
    select @genre.name, from: "place[genre_id]"
    fill_in "place[place_name]", with: "カフェ"
    fill_in "place[address]", with: "東京都新宿区"
    click_button "スポット登録"
    # 追加項目
    fill_in "place[detail]", with: "静かなカフェです"
    # fill_in "place[place_images_images]", with: "kk.jpg"
    # # fill_in "place[place_images_images][]", with: "jj.jpg"
    fill_in '場所の画像', with: 'kk.jpg'
    click_button "追加"
    # 表示確認
    # expect(page).to have_content @genre.name
    expect(page).to have_content 'kk.jpg'
  end
end
