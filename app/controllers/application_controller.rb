class ApplicationController < ActionController::Base
  protect_from_forgery
  
	helper_method :admin?
	layout :layout
		
	def authorize
		unless admin?
			flash[:error] = "unauthorized access"
			redirect_to tickets_path
			false
		end
	end
	
	
	def admin?
		current_user = User.find_by_seKey(session[:username])
		if current_user
			if current_user.isAdmin == true
				true
			else
				false
			end
		end
	end
	
	def logged_in? 
		unless session[:username] 
		  flash[:warning] = "You need to log in first." 
		  session[:return_to] = request.url
		  redirect_to login_path 
		  return false 
		else 
		  return true 
		end 
	end
	
	
	def layout
		# only turn it off for login pages:
		is_a?(LoginsController) ? false : "application"
	end
	
 
end
