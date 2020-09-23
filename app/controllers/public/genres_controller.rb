class Public::GenresController < ApplicationController
	before_action :authenticate
	before_action :guest, except: [:index, :create, :edit, :update]
	def index
		@genre = Genre.new
		@genres = Genre.all
	end

	def create
		@genre = Genre.new(genre_params)
		# binding.pry
		# saveに
		if @genre.save
			redirect_to public_genres_path
		else
			@genres = Genre.all
			render action: 'index'
		end
	end

	def edit
		@genre = Genre.find(params[:id])
	end

    def update
    	@genre = Genre.find(params[:id])
		if @genre.update(genre_params)
        	redirect_to public_genres_path
        else
        	render action: "edit"
        end
	end

	def destroy
		@genre = Genre.find(params[:id])
		@genre.destroy
		redirect_to public_genres_path
	end

	private
	def genre_params
		params.require(:genre).permit(:name, :customer_id)
	end
	# ログインしていないユーザーはTOPページに遷移
	def authenticate
  		redirect_to root_path unless customer_signed_in?
	end
	def guest
		redirect_to root_path if current_customer.email == "guest@guestpp"
	end
end
