class Public::GroupsCustomersController < ApplicationController
	before_action :authenticate
	before_action :guest, except: [:index, :members_show, :maps_show]
	def index
		@group_customer_add = GroupsCustomer.new
		# 重複しているグループを表示させない
		@groups_customer = GroupsCustomer.select(:group_id).distinct
		# ログイン中のユーザーが所属しているグループ
		@groups = GroupsCustomer.where(customer_id: current_customer.id)
	end
	def members_show
		@group = Group.find(params[:id])
		@groups = GroupsCustomer.where(group_id: @group.id)

	end
	def maps_show
		@group = Group.find(params[:id])
		# マップの初期値
		@center_place = Place.find_by(group_id: @group.id)

		# グループの場所の投稿が無い場合
		if @center_place.nil?
			@center_place = Place.new
			# 東京の緯度と経度
			@center_place.latitude = 35.6828387
			@center_place.longitude = 139.7594549
		end

	end


	def create
		@group_customer = GroupsCustomer.new(group_customer_params)
		@group = Group.find(params["groups_customer"]["group_id"])

		# groupのis_closed(公開ステータス)がfalse(公開)の場合、誰でもグループに加入できる
		if @group_customer.group.is_closed == false
			@group_customer.save
			flash[:group_add] = "グループに加入しました"
			redirect_to public_groups_customers_path and return
		else
			# key_word(合言葉)が必要なgroupに加入できた場合
			if @group.key_word == params["groups_customer"]["key_word"]
				@group_customer.save
				flash[:group_add] = "グループに加入しました"
				redirect_to public_groups_customers_path and return
			else
			# key_word(合言葉)の間違い
				flash[:not_key_word] = "合言葉が間違っています"
      			redirect_to public_groups_customers_path and return
			end
		end
	end


	def destroy
      @group_customer = GroupsCustomer.find(params[:id])
      @group_customer.destroy
      redirect_to public_groups_customers_path
    end
	private
	def group_customer_params
		params.require(:groups_customer).permit(:customer_id, :group_id, :is_admin)
	end
	# ゲストログインの制限
	def guest
		redirect_to root_path if current_customer.email == "guest@guestpp"
	end
	# ログインしていないユーザーはTOPページに遷移
	def authenticate
  		redirect_to root_path unless customer_signed_in?
	end
end
