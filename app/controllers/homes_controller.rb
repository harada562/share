class HomesController < ApplicationController
	before_action :authenticate, only: [ :top_select]
	def top
	end

	def about
	end

	def top_select
	end
	private
	# ログインしていないユーザーはTOPページに遷移
	def authenticate
  		redirect_to root_path unless customer_signed_in?
	end
end
