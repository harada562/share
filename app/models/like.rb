class Like < ApplicationRecord
  belongs_to :customer
  belongs_to :place

  # 空白NG
  validates :customer_id, presence: true
  validates :place_id, presence: true

  # いいね機能
  validates_uniqueness_of :place_id, scope: :customer_id
end
