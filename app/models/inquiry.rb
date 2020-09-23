class Inquiry < ApplicationRecord
	belongs_to :customer
	enum status: {対応待ち: 0, 対応中: 1, 対応済み: 2}

	# 空白NG
	validates :customer_id, presence: true
	validates :title, presence: true
	validates :body, presence: true
	validates :status, presence: true
end
