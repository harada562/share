require 'rails_helper'

RSpec.describe Group, type: :model do
  context "データが正しく保存される" do
    before do
      @group = Group.new
      @group.name = "Hello"
      @group.save
    end
    it "全て入力してあるので保存される" do
      expect(@group).to be_valid
    end
  end
  context "データが正しく保存されない" do
    before do
      @group = Group.new
      @group.name = ""
      @group.save
    end
    it "nameが入力されていないので保存されない" do
      expect(@group).to be_invalid
      expect(@group.errors[:name]).to include("を入力してください")
    end
  end
end
