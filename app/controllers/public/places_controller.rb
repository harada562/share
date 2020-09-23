class Public::PlacesController < ApplicationController
	before_action :authenticate
	before_action :guest, except: [:index, :show]
	def index
		@place = Place.new
		@places = Place.all.page(params[:page]).per(7)
		@center_place = Place.first
	end

	def new
		@place = Place.new
		@genre = Genre.where(customer_id: current_customer.id)
	end

	def create
		@place = Place.new(place_params)
			if @place.save
				redirect_to public_customer_path(@place.customer.id)
			else
				render :new
			end
	end
	def show
		@place = Place.find(params[:id])
		# binding.pry
	end

	def edit
		@place = Place.find(params[:id])
	end

	def update
		@place = Place.find(params[:id])
		if @place.update(place_params)
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
		params.require(:place).permit( :genre_id, :place_name, :customer_id, :address, :latitude, :longitude, :group_id, :number, :budget, :place_url)
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
