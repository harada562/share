class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?
	# 新規登録後のリダイレクト先
	def after_sign_up_path_for(resource)
    	home_top_select_path
	end

	# ログイン後のリダイレクト先
	def after_sign_in_path_for(resource)
	  case resource
	  	when Admin
	    	admin_inquiries_path
	  	when Customer
    		home_top_select_path
		end
	end

	# ログアウト後のリダイレクト先
	def after_sign_out_path_for(resource)
	  if resource == :admin
	    new_admin_session_path
	  else
	    root_path
	  end
	end

	protected
	def configure_permitted_parameters
	devise_parameter_sanitizer.permit(:sign_up, keys: [:nick_name])
	devise_parameter_sanitizer.permit(:sign_up,keys:[:email])
	end

end
