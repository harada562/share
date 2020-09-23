class Genre < ApplicationRecord
	has_many :places, dependent: :destroy

	# 空白NG
  	validates :name, presence: true
end
