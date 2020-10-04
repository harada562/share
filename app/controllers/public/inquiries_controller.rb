class Public::InquiriesController < ApplicationController
	before_action :authenticate
	def index
		@inquiries = Inquiry.where(customer_id: current_customer.id).order(id: "DESC")
		@inquiry = Inquiry.new
	end

	def create
		@inquiry = Inquiry.new(inquiry_params)
		if @inquiry.save
			redirect_to public_inquiries_path
		else
			@inquiries = Inquiry.where(customer_id: current_customer.id)
			render :index
		end
	end

	private
	def inquiry_params
		params.require(:inquiry).permit(:customer_id, :title, :body, :status)
	end
	# ログインしていないユーザーはTOPページに遷移
	def authenticate
  		redirect_to root_path unless customer_signed_in?
	end
end
