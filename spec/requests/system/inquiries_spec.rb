require 'rails_helper'

RSpec.describe "System::Inquiries", type: :request do
  scenario "お問い合わせ作成" do
    # customer作成
    @customer = create(:customer)

    visit new_customer_session_path
    fill_in "customer[nick_name]", with: @customer.nick_name
    fill_in "customer[password]", with: @customer.password
    click_button "ログイン"
    # お問い合わせ画面に遷移
    visit public_inquiries_path
    fill_in "inquiry[title]", with: "お問い合わせタイトル＠＊＋：」＾"
    fill_in "inquiry[body]", with: "お問い合わせ内容＠＊＋；＾"
    click_button "お問い合わせ"
    # 表示確認
    expect(page).to have_content "お問い合わせタイトル＠＊＋：」＾"
    expect(page).to have_content "お問い合わせ内容＠＊＋；＾"
    expect(page).to have_content "対応待ち"
  end
  scenario "お問い合わせ対応ステータス変更" do
    # 管理者作成
    @admin = create(:admin)
    @inquiry = create(:inquiry)
    @inquiry2 = create(:inquiry)
    # 管理者ログイン画面に遷移
    visit new_admin_session_path
    # ログイン処理
    fill_in "admin[nick_name]", with: @admin.nick_name
    fill_in "admin[password]", with: @admin.password
    click_button "Log in"

    visit admin_inquiries_path
    # 最初にみつかる詳細画面というリンクをクリック
    first(:link, '詳細画面', :href => edit_admin_inquiry_path(@inquiry.id)).click
    # 表示確認
    expect(page).to have_content "お問い合わせタイトル1"
    expect(page).to have_content "お問い合わせ内容1"
    expect(page).to have_content "対応待ち"
    select "対応中", from: "inquiry[status]"
    click_button "更新"
    expect(page).to have_content "対応中"

    # ユーザー側の表示が変わっているかの確認
    visit new_customer_session_path
    fill_in "customer[nick_name]", with: @inquiry.customer.nick_name
    fill_in "customer[password]", with: @inquiry.customer.password
    click_button "ログイン"
    visit public_inquiries_path
    # 表示確認
    expect(page).to have_content "お問い合わせタイトル1"
    expect(page).to have_content "お問い合わせ内容1"
    expect(page).to have_content "対応中"
  end
end
