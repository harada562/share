require 'rails_helper'

RSpec.describe "System::Places", type: :request do
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
	#場所作成画面に遷移
    visit new_public_place_path
    # 必須項目を入力
    select @genre.name, from: "place[genre_id]"
    fill_in "place[place_name]", with: "カフェ"
    fill_in "place[address]", with: "東京都新宿区"
    click_button "スポット登録"
    # 追加項目
    fill_in "place[place_url]", with: "placeshare.work"
    fill_in "place[number]", with: "12345678910"
    fill_in "place[budget]", with: "1000"
    fill_in "place[detail]", with: "静かなカフェです"
    click_button "追加"
    # 表示確認
    expect(page).to have_content @genre.name
    expect(page).to have_content 'カフェ'
    expect(page).to have_content '東京都新宿区'
    expect(page).to have_content 'placeshare.work'
    expect(page).to have_content '12345678910'
    expect(page).to have_content '1000'
    expect(page).to have_content '静かなカフェです'
    # マイページの表示
    visit public_customer_path(@customer.id)
    expect(page).to have_content 'カフェ'
    expect(page).to have_content '東京都新宿区'
  end
  scenario "場所の編集" do
    @place = create(:place)
    # 変更用ジャンル
    @genre = create(:genre)
    # ログイン
    visit new_customer_session_path
    fill_in "customer[nick_name]", with: @place.customer.nick_name
    fill_in "customer[password]", with: @place.customer.password
    click_button "ログイン"
    # 編集画面に遷移
    visit edit_public_place_path(@place.id)
    # 必須項目を変更
    select @genre.name, from: "place[genre_id]"
    fill_in "place[place_name]", with: "たこ焼き屋"
    fill_in "place[address]", with: "大阪府大阪市"
    # 追加項目
    fill_in "place[place_url]", with: "takoyaki.work"
    fill_in "place[number]", with: "0987654321"
    fill_in "place[budget]", with: "600"
    fill_in "place[detail]", with: "賑やかな場所です"
    click_button "スポット変更"
    # 表示確認
    expect(page).to have_content @genre.name
    expect(page).to have_content 'たこ焼き屋'
    expect(page).to have_content '大阪府大阪市'
    expect(page).to have_content 'takoyaki.work'
    expect(page).to have_content '0987654321'
    expect(page).to have_content '600'
    expect(page).to have_content '賑やかな場所です'
    # マイページの表示確認
    visit public_customer_path(@place.customer.id)
    expect(page).to have_content 'たこ焼き屋'
    expect(page).to have_content '大阪府大阪市'
  end
  scenario "場所の削除" do
  	@place = create(:place)
    # ログイン
    visit new_customer_session_path
    fill_in "customer[nick_name]", with: @place.customer.nick_name
    fill_in "customer[password]", with: @place.customer.password
    click_button "ログイン"
    # 編集画面に遷移
    visit public_place_path(@place.id)
    click_link "削除"

    # 削除されたかの確認
    visit public_customer_path(@place.customer.id)
    expect(page).to_not have_content @place.place_name
    expect(page).to_not have_content @place.address

  end
end
