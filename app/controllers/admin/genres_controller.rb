class Admin::GenresController < ApplicationController
	before_action :authenticate
	def index
		@genre = Genre.new
		@genres = Genre.all
	end

	def create
		@genre = Genre.new(genre_params)
		if @genre.save
			redirect_to admin_genres_path
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
        	redirect_to admin_genres_path
        else
        	render action: "edit"
        end
	end

	def destroy
		@genre = Genre.find(params[:id])
		@genre.destroy
		redirect_to admin_genres_path
	end

	private
	def genre_params
		params.require(:genre).permit(:name, :customer_id)
	end
	# 管理者ページはログインしていないと操作できない
	def authenticate
  		redirect_to admin_session_path unless admin_signed_in?
	end
end
