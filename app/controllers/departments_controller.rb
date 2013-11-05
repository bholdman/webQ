class DepartmentsController < ApplicationController
	def index
		if admin?	
			@departments = Department.order("name")
		else
			flash[:error] = 'You are not allowed to access that page'
			redirect_to user_path(session[:username])
		end
	end
	
	def show
		@departments = Department.find(params[:id])
	end
end
