class Group < ApplicationRecord
	has_many :places, dependent: :destroy
	has_many :groups_customers, dependent: :destroy

	# 空白NG
  	validates :name, presence: true
  	# validates :is_closed, presence: true

  	# 一意性
  	validates :name, uniqueness: true, allow_nil: true
  	# validates :key_word, uniqueness: true, allow_nil: true
end
