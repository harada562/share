class Admin::PlacesController < ApplicationController
	before_action :authenticate
	def index
		@places = Place.all
	end
	def show
		@place = Place.find(params[:id])
	end
	def destroy
      @place = Place.find(params[:id])
      @place.destroy
      redirect_to admin_places_path
    end
    # 管理者ページはログインしていないと操作できない
	private
	def authenticate
  		redirect_to admin_session_path unless admin_signed_in?
	end
end
