class Admin::CustomersController < ApplicationController
	before_action :authenticate
	def index
		@customers = Customer.all
	end
	def show
		@customer = Customer.find(params[:id])
	end
	def confirm
		@customer = Customer.find(params[:id])
	end

	def withdrawal
		@customer = Customer.find(params[:id])
        #is_deletedカラムにフラグを立てる(defaultはfalse)
        if @customer.is_deleted == false
        	@customer.update(is_deleted: true)
        else
        	@customer.update(is_deleted: false)
        end
        redirect_to admin_customers_path
	end

	# 管理者ページはログインしていないと操作できない
	private
	def authenticate
  		redirect_to admin_session_path unless admin_signed_in?
	end
end
