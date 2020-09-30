class Public::GroupsController < ApplicationController
	before_action :authenticate
	before_action :guest, except: [:show]
	def new
		@group = Group.new
		# @group.groups_customers.build
	end
	def create
		@group = Group.new(group_params)
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

	def show
		@group = Group.find(params[:id])
		 @group_customer_add = GroupsCustomer.new
		@groups = GroupsCustomer.where(group_id: @group.id)
		# 管理者を見つける
		@is_admin = GroupsCustomer.where(group_id: @group.id, is_admin: true)
		@places = Place.where(group_id: @group.id)
	end

	def new_key_word
		@key_word = Group.find(params[:id])
	end

	def edit
		@group = Group.find(params[:id])
	end
	def update
		@group = Group.find(params[:id])
		if @group.update(group_params)
        	redirect_to public_groups_customers_path
		else
			render :edit
		end
	end
	def destroy
      @group = Group.find(params[:id])
      @group.destroy
      redirect_to public_groups_customers_path
    end
	private
	def group_params
		params.require(:group).permit(:name, :is_closed, :key_word, :customer_id, :image, :introduction,
			groups_customers_attributes: [:customer_id, :group_id, :is_admin])
	end
	def guest
		redirect_to root_path if current_customer.nick_name == "げすと"
	end
	# ログインしていないユーザーはTOPページに遷移
	def authenticate
  		redirect_to root_path unless customer_signed_in?
	end
end