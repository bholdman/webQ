class UsersController < ApplicationController
	
	before_filter :logged_in?

	def index
		if admin?
			if params[:sort]
				@users = User.order(params[:sort] + " " + params[:direction])
			else
				@users = User.order('fName', 'lName')
			end
			
			@assignments = User.where("isAdmin = 1 AND fName like ?", "%#{params[:q]}%").select(['id', 'CONCAT_WS(" ", fName, lName ) as name'])
			
			respond_to do |format|
				format.html
				format.json { render :json => @assignments }
			end
		else
			flash[:error] = 'You are not allowed to access that page'
			redirect_to user_path(session[:username])
		end
	end
	
	def show
		@departments = Department.order('name')
		@users = User.find_by_seKey(params[:id])
		if admin? or @users.seKey == session[:username]
			@tickets = User.find_by_seKey(params[:id]).tickets.where('isOwner = 1').order('status_id asc')
		else
			flash[:error] = 'You are not allowed to access that page'
			redirect_to user_path(session[:username])
		end
	end
	
	def new
		@users = User.new
		@departments = Department.order('name')
	end
	
	def create
		@users = User.new(params[:user])
		@users.save
		redirect_to department_path(@departments)
	end
	
	def become()
		@new_user = User.find_by_seKey(params[:seKey])
		session[:username] = @new_user.seKey
		session[:user_id] = @new_user.id
		session[:fullName] = "#{@new_user.fName} #{@new_user.lName}"
		redirect_to tickets_path
	end
	
	def update
	  @myUser = User.find_by_seKey(params[:id])
	  if @myUser.update_attributes(params[:user])
		flash[:success] = "Profile updated."
		redirect_to users_url
	  else
		render :action => :edit
	  end
	end
	
	def increment_thanks()
		@my_user = User.find(params[:id])
		@my_user.thanks_count +=1
		@my_user.save
		redirect_to(:back)
	end
	
	
end
