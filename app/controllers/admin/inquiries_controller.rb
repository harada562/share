class Admin::InquiriesController < ApplicationController
	before_action :authenticate
	def index
		@inquiries = Inquiry.all
	end
	def edit
		@inquiry = Inquiry.find(params[:id])
	end
	def update
		@inquiry = Inquiry.find(params[:id])
		@inquiry.update(inquiry_params)
        redirect_to admin_inquiries_path
	end
	private
	def inquiry_params
		params.require(:inquiry).permit(:customer_id, :title, :body, :status)
	end
	# 管理者ページはログインしていないと操作できない
	private
	def authenticate
  		redirect_to admin_session_path unless admin_signed_in?
	end
end
