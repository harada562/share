require 'rails_helper'

RSpec.describe "System::Customers", type: :request do

  describe "新規登録画面" do
    before do
      visit new_customer_registration_path
    end
    it "表示の確認" do
      expect(page).to have_content("新規登録")
    end
    context '新規登録実行' do
      it "値が正しい場合" do
        fill_in 'customer[nick_name]', with: 'example'
        fill_in 'customer[email]', with: 'foooo@example.com'
        fill_in 'customer[password]', with: '123456'
        fill_in 'customer[password_confirmation]', with: '123456'
        click_button '新規登録'
        expect(page).to have_content 'ようこそ'
      end
      it "ニックネームが正しくない場合" do
        fill_in 'customer[nick_name]', with: ''
        fill_in 'customer[email]', with: 'foooo@example.com'
        fill_in 'customer[password]', with: '123456'
        fill_in 'customer[password_confirmation]', with: '123456'
        click_button '新規登録'
        expect(page).to have_content '3文字以上で入力してください'
      end
      it "パスワードが一致しない場合" do
        fill_in 'customer[nick_name]', with: ''
        fill_in 'customer[email]', with: 'foooo@example.com'
        fill_in 'customer[password]', with: '123456'
        fill_in 'customer[password_confirmation]', with: '1234567'
        click_button '新規登録'
        expect(page).to have_content 'パスワード確認とパスワードの入力が一致しません'
      end
    end

    it 'ログイン画面に移動' do
      click_link '新規登録がお済みの方'
      expect(page).to have_content("ログイン")
    end
  end

  describe "ログイン画面" do
  	before do
      visit new_customer_registration_path
      fill_in 'customer[nick_name]', with: 'example'
      fill_in 'customer[email]', with: 'foooo@example.com'
      fill_in 'customer[password]', with: '123456'
      fill_in 'customer[password_confirmation]', with: '123456'
      click_button '新規登録'
      click_link 'ログアウト'
      visit new_customer_session_path
    end
    it "表示の確認" do
      expect(page).to have_content("新規登録が済んでない方")
    end
    context 'ログイン実行' do
      it "値が正しい場合" do
        fill_in 'customer[nick_name]', with: 'example'
        fill_in 'customer[password]', with: '123456'
        click_button 'ログイン'
        expect(page).to have_content 'ようこそ'
      end
      it "ニックネームが正しくない場合" do
        fill_in 'customer[nick_name]', with: 'exa'
        fill_in 'customer[password]', with: '123456'
        click_button 'ログイン'
        expect(page).to have_content 'ログイン'
      end
    end

    it '新規登録画面に移動' do
    	click_link '新規登録が済んでない方'
    	expect(page).to have_content("新規登録")
    end
  end

  describe "マイページ" do
    before do
      visit new_customer_registration_path
      fill_in 'customer[nick_name]', with: 'example'
      fill_in 'customer[email]', with: 'foooo@example.com'
      fill_in 'customer[password]', with: '123456'
      fill_in 'customer[password_confirmation]', with: '123456'
      click_button '新規登録'
      click_link 'マイページ'
    end
    it "表示の確認" do
      expect(page).to have_content 'マイページ'
    end
    it "リンクの確認" do
      expect(page).to have_link '自己紹介文を追加しよう'
      expect(page).to have_link 'グループを探そう'
      expect(page).to have_link 'スポット登録してみよう'
      expect(page).to have_link '編集'
    end
  end
  describe "編集" do
    before do
      visit new_customer_registration_path
      fill_in 'customer[nick_name]', with: 'example'
      fill_in 'customer[email]', with: 'foooo@example.com'
      fill_in 'customer[password]', with: '123456'
      fill_in 'customer[password_confirmation]', with: '123456'
      click_button '新規登録'
      click_link 'マイページ'
      click_link '編集'
    end
    it "表示の確認" do
      expect(page).to have_content 'ユーザー編集画面'
    end
    it "リンクの確認" do
      expect(page).to have_button '変更'
      expect(page).to have_link '退会'
    end
    context '編集の実行' do
      it "値が正しい場合" do
          fill_in 'customer[nick_name]', with: 'イグザンプル'
          click_button '変更'
          expect(page).to have_content 'イグザンプル'
      end
      it "ニックネームが正しくない場合" do
        fill_in 'customer[nick_name]', with: ''
        click_button '変更'
        expect(page).to have_content '3文字以上で入力してください'
      end
      it "メールアドレスが正しくない場合" do
        fill_in 'customer[email]', with: ''
        click_button '変更'
        expect(page).to have_content 'メールアドレスを入力してください'
      end
    end
  end
  describe "退会" do
    before do
      visit new_customer_registration_path
      fill_in 'customer[nick_name]', with: 'example'
      fill_in 'customer[email]', with: 'foooo@example.com'
      fill_in 'customer[password]', with: '123456'
      fill_in 'customer[password_confirmation]', with: '123456'
      click_button '新規登録'
      click_link 'マイページ'
      click_link '編集'
      click_link '退会'
    end
    it "表示の確認" do
      expect(page).to have_content '本当に退会しますか？'
    end
    it "リンクの確認" do
      expect(page).to have_link '退会しない'
      expect(page).to have_link '退会する'
    end
    context '退会の実行' do
      it "退会する場合" do
        click_link '退会する'
        click_link 'ログイン'
        fill_in 'customer[nick_name]', with: 'example'
        fill_in 'customer[password]', with: '123456'
        click_button 'ログイン'
        expect(page).to have_content 'ログイン'
      end
      it "退会しない場合" do
         click_link '退会しない'
         expect(page).to have_content 'マイページ'
      end
    end
  end
end
