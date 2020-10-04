require 'rails_helper'

RSpec.describe "System::Groups", type: :request do
  describe "グループ" do
  	before do
      visit new_customer_registration_path
      fill_in 'customer[nick_name]', with: 'example'
      fill_in 'customer[email]', with: 'foooo@example.com'
      fill_in 'customer[password]', with: '123456'
      fill_in 'customer[password_confirmation]', with: '123456'
      click_button '新規登録'
      click_link 'グループ作成'
    end
    it "表示の確認" do
    	expect(page).to have_content("グループ作成")
    end
    it "リンクの確認" do
    	expect(page).to have_button '作成'
    end
    context 'グループ作成の実行(成功)' do
      it "値が正しい場合(公開)" do
      	fill_in 'group[name]', with: 'hoge'
        choose 'group_is_closed_false'
      	click_button 'グループ作成'
      	expect(page).to have_content("hoge")
      end
      it "値が正しい場合(非公開)" do
        fill_in 'group[name]', with: 'hoge'
        choose 'group_is_closed_true'
        fill_in 'group[key_word]', with: 'hogehoge'
        click_button 'グループ作成'
        expect(page).to have_content("hoge")
      end
    end
    context 'グループ作成の実行（失敗）' do
      it "値が正しくない場合(公開)" do
        fill_in 'group[name]', with: ''
        choose 'group_is_closed_false'
        click_button 'グループ作成'
        expect(page).to have_content("グループ名を入力してください")
      end
      it "値が正しくない場合(非公開)" do
        fill_in 'group[name]', with: 'hoge'
        choose 'group_is_closed_true'
        fill_in 'group[key_word]', with: ''
        click_button 'グループ作成'
        expect(page).to have_content("合言葉を入力してください")
      end
    end
  end
end
