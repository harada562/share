class Like < ApplicationRecord
	belongs_to :customer
	belongs_to :place
	validates_uniqueness_of :place_id, scope: :customer_id
end
