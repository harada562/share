class Public::GroupsCustomersController < ApplicationController
  before_action :authenticate
  before_action :guest, except: [:index, :members_show, :maps_show]
  def index
    # 重複しているグループを表示させない
    @groups_customer = GroupsCustomer.select(:group_id).distinct.page(params[:page]).per(7).order(id: "DESC")
    # ログイン中のユーザーが所属しているグループ
    @groups = GroupsCustomer.where(customer_id: current_customer.id).order(id: "DESC")
  end

  def members_index
    @group_customer_add = GroupsCustomer.new
    @group = Group.find(params[:id])
    @groups = GroupsCustomer.where(group_id: @group.id)
    # 管理者
    @is_admin = GroupsCustomer.where(group_id: @group.id, is_admin: true)
  end

  def maps_index
    @group_customer_add = GroupsCustomer.new
    @group = Group.find(params[:id])
    @groups = GroupsCustomer.where(group_id: @group.id)
    @places = Place.where(group_id: @group.id)

    # 管理者
    @is_admin = GroupsCustomer.where(group_id: @group.id, is_admin: true)

    # マップの初期値
    @center_place = Place.find_by(group_id: @group.id)
    # binding.pry
    # グループの場所の経度が無い場合
    # binding.pry
    if @center_place.nil? || @center_place.latitude.nil?
      @center_place = Place.new
      # 東京の緯度と経度
      @center_place.latitude = 35.6828387
      @center_place.longitude = 139.7594549
    end
  end

  def key_word
    @group_customer_add = GroupsCustomer.new
    @group = Group.find(params[:id])
  end

  def create
    @group_customer = GroupsCustomer.new(group_customer_params)
    @group = Group.find(params["groups_customer"]["group_id"])

    # groupのis_closed(公開ステータス)がfalse(公開)の場合、誰でもグループに加入できる
    if @group_customer.group.is_closed == false
      @group_customer.save
      flash[:group_add] = "グループに加入しました"
      redirect_to(maps_public_groups_customer_path(@group_customer.group.id)) && return
    else
      # key_word(合言葉)が必要なgroupに加入できた場合
      if @group.key_word == params["groups_customer"]["key_word"]
        @group_customer.save
        flash[:group_add] = "グループに加入しました"
        redirect_to(maps_public_groups_customer_path(@group_customer.group.id)) && return
      else
        # key_word(合言葉)の間違い
        flash[:not_key_word] = "合言葉が間違っています"
        redirect_to(key_word_public_groups_customer_path(@group_customer.group.id)) && return
      end
    end
  end

  def destroy
    @group_customer = GroupsCustomer.find(params[:id])
    @group_customer.destroy
    redirect_to public_customer_path(current_customer.id)
  end

  private

  def group_customer_params
    params.require(:groups_customer).permit(:customer_id, :group_id, :is_admin)
  end

  # ゲストログインの制限
  def guest
    redirect_to root_path if current_customer.nick_name == "げすと"
  end

  # ログインしていないユーザーはTOPページに遷移
  def authenticate
    redirect_to root_path unless customer_signed_in?
  end
end
