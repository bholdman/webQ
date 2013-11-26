class LoginsController < ApplicationController

	def create
		if cookies[:auth_token]
			@current_user = User.find_by_auth_token(cookies[:auth_token])
			create_session
			flash[:notice] = 'Successfully logged in'
			redirect_to tickets_path
		else
			do_login
		end
		
		
		
	end
	
	def new
		if cookies[:auth_token]
			@current_user = User.find_by_auth_token(cookies[:auth_token])
			create_session
			flash[:notice] = 'Successfully logged in'
			redirect_to tickets_path
		else
			#do_login
		end
	end
	
	
	def destroy
		if cookies[:auth_token]
			cookies.delete(:auth_token)
		end
		reset_session
		flash[:notice] = 'Successfully logged out'
		
		redirect_to login_path
	end
	
	def do_login
		@current_user = User.find_by_seKey(params[:username])
		
		if @current_user and not(params[:password].blank?)
			ldap = Net::LDAP.new
			ldap.host = 'semoad.semo.edu'
			ldap.auth "#{@current_user.seKey}@semo.edu", params[:password]
			
			if ldap.bind
				if params[:remember_me]
					cookies.permanent[:auth_token] = @current_user.auth_token
				else
					cookies[:auth_token] = @current_user.auth_token
				end
				
				create_session
				flash[:notice] = 'Successfully logged in'
				if !session[:return_to].nil?
					redirect_to session[:return_to]
				else
					redirect_to tickets_path
				end
				session[:return_to] = nil
			else
				flash.now.alert = 'Incorrect seKey or password'
				render "new"
			end
		else
			flash.now.alert = 'Incorrect seKey or password'
			render "new"
		end
	end
	

	def create_session
		session[:username] = @current_user.seKey
		session[:user_id] = @current_user.id
		session[:fullName] = "#{@current_user.fName} #{@current_user.lName}"
	end
	

	
end
