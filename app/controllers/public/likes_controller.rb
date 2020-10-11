class Public::LikesController < ApplicationController
  before_action :authenticate
  def create
    @place = Place.find(params[:place_id])
    @like = current_customer.likes.build(place_id: params[:place_id])
    @like.save
    # binding.pry
  end

  def destroy
    @place = Place.find(params[:place_id])
    @like = Like.find_by(place_id: params[:place_id], customer_id: current_customer.id)
    @like.destroy
  end

  private

  # ログインしていないユーザーはTOPページに遷移
  def authenticate
    redirect_to root_path unless customer_signed_in?
  end
end
