class Public::GroupsController < ApplicationController
	before_action :authenticate
	before_action :guest
	def new
		@group = Group.new
		# @group.groups_customers.build
	end
	def create
		@group = Group.new(group_params)
		binding.pry
			groups_customer = @group.groups_customers.build
			groups_customer.group_id = @group.id
			groups_customer.customer_id = current_customer.id
			groups_customer.is_admin = true
		if @group.save
			groups_customer.save
			redirect_to public_groups_customers_path
		else
			render :new
		end
	end
	def destroy
      @group = Group.find(params[:id])
      @group.destroy
      redirect_to public_groups_customers_path
    end
	private
	def group_params
		params.require(:group).permit(:name, :is_closed, :key_word, :customer_id,
			groups_customers_attributes: [:customer_id, :group_id, :is_admin])
	end
	def guest
		redirect_to root_path if current_customer.email == "guest@guestpp"
	end
	# ログインしていないユーザーはTOPページに遷移
	def authenticate
  		redirect_to root_path unless customer_signed_in?
	end
end