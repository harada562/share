
class Place < ApplicationRecord
	belongs_to :genre, optional: true
	belongs_to :customer
	belongs_to :group, optional: true

	# 3文字以上
	validates :address,length: { minimum: 3 }

	# 空白NG
	validates :customer_id, presence: true
	validates :place_name, presence: true
	# validates :latitude, presence: true
	# validates :longitude, presence: true

	# 数値のみ
	# validates :number, numericality: true

	# 経度、緯度表示機能
	geocoded_by :address
  	after_validation :geocode, if: :address_changed?

  	# いいね機能
	has_many :likes
	has_many :liked_customers, through: :likes, source: :customer

end
