class HomesController < ApplicationController
	before_action :authenticate, only: [ :top_select]
	def top
	end

	def about
	end

	def top_select
		@gorups = GroupsCustomer.where(customer_id: current_customer.id)
		@places = Place.where(customer_id: current_customer.id)
	end
	private
	# ログインしていないユーザーはTOPページに遷移
	def authenticate
  		redirect_to root_path unless customer_signed_in?
	end
end
