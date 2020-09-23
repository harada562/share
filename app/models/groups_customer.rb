class GroupsCustomer < ApplicationRecord
	belongs_to :customer
	belongs_to :group

	# 空白NG
  	# validates :customer_id, presence: true
  	# validates :group_id, presence: true
end
