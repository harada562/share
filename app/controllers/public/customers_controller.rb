class Public::CustomersController < ApplicationController
  before_action :authenticate
  before_action :guest, except: [:index, :show]
  def index
    @customers = Customer.all.page(params[:page]).per(8).order(id: "DESC")
  end

  def show
    @customer = Customer.find(params[:id])
    # 投稿件数
    @places = Place.where(customer_id: @customer.id)
    # 所属グループ
    @groups = GroupsCustomer.where(customer_id: @customer.id).page(params[:page]).per(3)
    # 自分の投稿
    @places = Place.where(customer_id: @customer.id).page(params[:page]).per(4)
    # マップの初期値
    @center_place = @places.first
    # binding.pry
    # グループの場所の投稿が無い場合
    if @center_place.nil?
      @center_place = Place.new
      # 東京の緯度と経度
      @center_place.latitude = 35.6828387
      @center_place.longitude = 139.7594549
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to public_customer_path(@customer.id)
    else
      render :edit
    end
  end

  def confirm
    @customer = Customer.find(params[:id])
  end

  def withdrawal
    @customer = Customer.find(params[:id])
    # is_deletedカラムにフラグを立てる(defaultはfalse)
    @customer.update(is_deleted: true)
    # ログアウトさせる
    reset_session
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:nick_name, :email, :intoroduction, :image)
  end

  def guest
    redirect_to root_path if current_customer.nick_name == "げすと"
  end

  # ログインしていないユーザーはTOPページに遷移
  def authenticate
    redirect_to root_path unless customer_signed_in?
  end
end
