class PlaceImage < ApplicationRecord
  belongs_to :place, optional: true
  # 画像投稿用
  attachment :image

  # place_idの空白NG
  validates :place_id, presence: true
end
