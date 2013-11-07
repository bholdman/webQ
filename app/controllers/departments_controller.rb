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
		@users = Department.find_by_id(params[:id]).users
		@tickets = Department.find_by_id(params[:id]).tickets
	end

	def new
		@departments = Department.new
	end
	
	def create
	
		@departments = Department.new(params[:department])
		@departments.save
		redirect_to department_path(@departments)
	end

	def update
	  @myDept = Department.find_by_id(params[:id])

	  if @myDept.update_attributes(params[:department])
		flash[:notice] = "Department updated successfully"
		redirect_to departments_url
	  else
		render :action => :edit
	  end
	end
end
