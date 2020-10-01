require 'rails_helper'

RSpec.describe Genre, type: :model do
  context "データが正しく保存される" do
    before do
      @genre = Genre.new
      @genre.name = "Hello WebCamp"
      @genre.save
    end
    it "全て入力してあるので保存される" do
      expect(@genre).to be_valid
    end
  end

  context "データが正しく保存されない" do
    before do
      @genre = Genre.new
      @genre.name = ""
      @genre.save
    end
    it "nameが入力されていないので保存されない" do
      expect(@genre).to be_invalid
      expect(@genre.errors[:name]).to include("を入力してください")
    end
  end
end
