Rails.application.routes.draw do
# カスタマーroutes
	root 'homes#top'
	get 'home/top', to:'homes#top'
	get 'home/about', to:'homes#about'
	get 'home/top_select', to:'homes#top_select'
	devise_for :customers
	namespace :public do
		resources :customers do
			member do
				get 'confirm', to:'customers#confirm'
				put "withdrawal" => "customers#withdrawal"
			end
		end
		resources :inquiries
		resources :groups
		resources :groups_customers do
			member do
				get 'menbers', to: 'groups_customers#members_show'
				get 'maps', to: 'groups_customers#maps_show'
			end
		end
		resources :places do
			resources :likes, only: [:create, :destroy]
		end
	end

# 管理者routes
	devise_for :admins
	namespace :admin do
		resources :inquiries, only: [:index, :edit, :update]
		resources :customers, only: [:index, :show] do
			member do
				get 'confirm', to:'customers#confirm'
				put "withdrawal" => "customers#withdrawal"
			end
		end
		resources :genres, only: [:index, :edit, :create, :destroy, :update]
		resources :groups, only: [:index, :show, :destroy]
		resources :places, only: [:index, :show, :destroy]
	end

# ゲストログイン用
	devise_scope :customer do
    post 'customers/guest_sign_in', to: 'customers/sessions#new_guest'
  end
end
