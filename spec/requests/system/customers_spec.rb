require 'rails_helper'

RSpec.describe "System::Customers", type: :request do
  scenario "新規登録" do
    visit new_customer_registration_path
    fill_in "customer[nick_name]", with: "いっしー"
    fill_in "customer[email]", with: "issi@issi"
    fill_in "customer[password]", with: "123456"
    fill_in "customer[password_confirmation]", with: "123456"
    click_button "新規登録"
    # 表示確認
    expect(page).to have_content "いっしー"
  end
  scenario "ログイン" do
    @customer = create(:customer)

    visit new_customer_session_path
    fill_in "customer[nick_name]", with: @customer.nick_name
    fill_in "customer[password]", with: @customer.password
    click_button "ログイン"
    expect(page).to have_content @customer.nick_name
  end
  scenario "退会処理" do
     @customer = create(:customer)
     # ログインから退会までの流れ
    visit new_customer_session_path
    fill_in "customer[nick_name]", with: @customer.nick_name
    fill_in "customer[password]", with: @customer.password
    click_button "ログイン"
    visit edit_public_customer_path(@customer.id)
    click_link "退会"
    click_link "退会する"

    # 退会したcustomerはログインできないか確認
    visit new_customer_session_path
    fill_in "customer[nick_name]", with: @customer.nick_name
    fill_in "customer[password]", with: @customer.password
    click_button "ログイン"
    expect(page).to have_content "ログイン"
  end
  scenario "退会しない場合" do
    @customer = create(:customer)
     # ログインから退会までの流れ
    visit new_customer_session_path
    fill_in "customer[nick_name]", with: @customer.nick_name
    fill_in "customer[password]", with: @customer.password
    click_button "ログイン"
    visit edit_public_customer_path(@customer.id)
    click_link "退会"
    click_link "退会しない"
    expect(page).to have_content @customer.nick_name
  end
  scenario "会員一覧" do
    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @customer3 = create(:customer)
    visit new_customer_session_path
    fill_in "customer[nick_name]", with: @customer1.nick_name
    fill_in "customer[password]", with: @customer1.password
    click_button "ログイン"

    visit public_customers_path
    expect(page).to have_content @customer2.nick_name
    expect(page).to have_content @customer3.nick_name
  end
  scenario "編集" do
    @customer = create(:customer)
    visit new_customer_session_path
    fill_in "customer[nick_name]", with: @customer.nick_name
    fill_in "customer[password]", with: @customer.password
    click_button "ログイン"
    visit edit_public_customer_path(@customer.id)
    # すべの値を変更
    attach_file "customer[image]", "app/assets/images/profile.png"
    fill_in "customer[nick_name]", with: "山田太郎23"
    fill_in "customer[email]", with: "yamada@yamada.yamada1"
    fill_in "customer[intoroduction]", with: "よろしくお願いします。よろしくお願いします。"
    click_button "変更"
    # 表示確認
    expect(page).to have_content "山田太郎23"
    expect(page).to have_content "よろしくお願いします。よろしくお願いします。"

  end
  scenario "詳細" do
    @customer = create(:customer)
    @customer2 = create(:customer)
    visit new_customer_session_path
    fill_in "customer[nick_name]", with: @customer.nick_name
    fill_in "customer[password]", with: @customer.password
    click_button "ログイン"
    visit public_customers_path
    # ログインカスタマーは一覧に表示されないことを確認する
    expect(page).to_not have_link '詳細画面', href: public_customer_path(@customer.id)
    click_link '詳細画面', href: public_customer_path(@customer2.id)
    # 表示されてはいけないリンク
    expect(page).to_not have_link '編集画面', href: edit_public_customer_path(@customer.id)
    # 表示の確認
    expect(page).to have_content @customer2.nick_name
  end
end
