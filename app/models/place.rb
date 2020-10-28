class Place < ApplicationRecord
  belongs_to :genre
  belongs_to :customer

  # group_idを持たなくても保存できる
  belongs_to :group, optional: true

  # 複数画像投稿用
  has_many :place_images, dependent: :destroy
  accepts_attachments_for :place_images, attachment: :image

  # 3文字以上
  validates :address, length: { minimum: 3 }

  # 空白NG
  validates :customer_id, presence: true
  validates :place_name, presence: true

  # 経度、緯度表示機能
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  # いいね機能
  has_many :likes
  has_many :liked_customers, through: :likes, source: :customer
end
