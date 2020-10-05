class Public::LikesController < ApplicationController
  before_action :authenticate
  def create
    @like = current_customer.likes.create(place_id: params[:place_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = Like.find_by(place_id: params[:place_id], customer_id: current_customer.id)
    @like.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  # ログインしていないユーザーはTOPページに遷移
  def authenticate
    redirect_to root_path unless customer_signed_in?
  end
end
