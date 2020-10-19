class Public::PlacesController < ApplicationController
  before_action :authenticate
  def index
    # 検索機能
    @q = Place.ransack(params[:q])
    @ransack_place = @q.result(distinct: true).includes(:customer, :genre).
      where(group_id: nil).page(params[:page]).per(7).order(id: "DESC")
    @place = Place.new
    @center_place = @ransack_place.first
    if @center_place.nil? || @center_place.latitude.nil?
      @center_place = Place.new
      # 東京の緯度と経度
      @center_place.latitude = 35.6828387
      @center_place.longitude = 139.7594549
    end
  end

  def new
    @place = Place.new
    @place.place_images.build
    @genre = Genre.where(customer_id: current_customer.id)
  end

  def create
    # Placeの空のモデルにplace_paramsの型をはめてデータ保存
    @place = Place.new(place_params)
    if @place.save
      redirect_to place_new_add_public_place_path(@place.id)
    else
      render :new
    end
  end

  def place_new_add
    @place = Place.find(params[:id])
  end

  def show
    @place = Place.find(params[:id])
    @like = Like.where(place_id: @place.id).count
    # binding.pry
  end

  def edit
    @place = Place.find(params[:id])
    # @place.place_images.build
  end

  def update
    @place = Place.find(params[:id])
    if @place.update!(place_params)
      redirect_to public_place_path(@place.id)

    else
      render :edit
    end
  end

  def destroy
    @place = Place.find(params[:id])
    @place.destroy
    redirect_to public_customer_path(current_customer.id)
  end

  private

  def place_params
    params.require(:place).permit(:genre_id, :place_name, :customer_id, :address,
                                  :latitude, :longitude,
                                  :group_id, :number, :budget, :place_url, :detail,
                                  place_images_images: [])
  end

  # ログインしていないユーザーはTOPページに遷移
  def authenticate
    redirect_to root_path unless customer_signed_in?
  end
end
