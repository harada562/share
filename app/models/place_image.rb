class PlaceImage < ApplicationRecord
  belongs_to :place, optional: true
  # 画像投稿用
  attachment :image
end
