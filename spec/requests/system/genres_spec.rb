require 'rails_helper'

RSpec.describe "System::Genres", type: :request do
  scenario "ジャンルの作成" do
  	# 管理者作成
  	@admin = create(:admin)
  	# 管理者ログイン画面に遷移
  	visit new_admin_session_path
  	# ログイン処理
  	fill_in "admin[nick_name]", with: @admin.nick_name
    fill_in "admin[password]", with: @admin.password
    click_button "Log in"
    # ジャンル作成画面に遷移
    visit admin_genres_path
    # 項目を入力
    fill_in "genre[name]", with: "朝食"
    click_button "ジャンル作成"
    # 表示の確認
    expect(page).to have_content "朝食"
    expect(page).to have_link "編集画面"
    expect(page).to have_link "削除"
  end
  scenario "ジャンルの編集" do
  	@admin = create(:admin)
  	# ジャンル作成
  	@genre = create(:genre)

  	visit new_admin_session_path
  	fill_in "admin[nick_name]", with: @admin.nick_name
    fill_in "admin[password]", with: @admin.password
    click_button "Log in"
    # ジャンル編集画面に遷移
    visit edit_admin_genre_path(@genre.id)
    # 項目を入力
    fill_in "genre[name]", with: "昼食"
    click_button "ジャンル名変更"
	# 表示の確認
	expect(page).to have_content "昼食"
    expect(page).to have_link "編集画面"
    expect(page).to have_link "削除"
  end
  scenario "ジャンルの削除" do
  	@admin = create(:admin)
  	@genre = create(:genre)
  	@genre2 = create(:genre)

  	visit new_admin_session_path
  	fill_in "admin[nick_name]", with: @admin.nick_name
    fill_in "admin[password]", with: @admin.password
    click_button "Log in"
    visit admin_genres_path
   	first(:link, '削除').click
   	# 表示の確認
	expect(page).to have_content @genre2.name
    expect(page).to have_link "編集画面"
    expect(page).to have_link "削除"
  end
end
