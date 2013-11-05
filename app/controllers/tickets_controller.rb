class TicketsController < ApplicationController
	
	respond_to do |format|
		
	   format.rss { render :rss => Tickets.all }
	   format.html
      format.mobile
	   
	end
	
	before_filter :logged_in?
	
	
	def feed
		
	end

	def index
		if (params[:format] == "rss")
			@tickets = Ticket.all
		else
			if admin?
			if params[:sort]
					@tickets = Ticket.search(params[:search]).order(params[:sort] + " " + params[:direction]).page(params[:page])
				else
					@tickets = Ticket.search(params[:search]).order('status_id asc', 'created_at desc').page(params[:page])
				end
			else
				if params[:sort]
					@tickets = User.find(session[:user_id]).tickets.where('isOwner = 1').order(params[:sort] + " " + params[:direction]).page(params[:page])
				else
					@tickets = User.find(session[:user_id]).tickets.where('isOwner = 1').order('status_id asc', 'created_at desc').page(params[:page])
				end
			end
		end
	end
	
	def show
		@tickets = Ticket.find(params[:id])
		if @tickets.status.name == "New" and admin?
			@tickets.status_id = Status.find_by_name("Open").id
		end
		@tickets.save
		@owner = @tickets.assignments.find_by_isOwner(1)
		@users = User.find_by_id(@owner.user_id)
		@response = Response.new
		@response.ticket_id = @tickets.id
		@response.upload_id = 0
		@statuses = Status.all
		@attachments = Attachment.find_all_by_attachable_id(@tickets.id)
		@attachments_responses = Attachment.find_all_by_attachable_id(@response.id)

	end
	
	def new
		@ticket = Ticket.new		
	end
	
	def create
		if params[:ticket][:url].to_s[0..2].downcase == 'www'
			params[:ticket][:url] = 'http://' + params[:ticket][:url].downcase
		end
		if params[:ticket][:url].to_s[0..7].downcase == 'semo.edu'
			params[:ticket][:url] = 'http://www.' + params[:ticket][:url].downcase
		end
		
		@ticket = Ticket.new(params[:ticket])
		@ticket.status_id = 1
		#@ticket.user_id = session[:user_id]
		@ticket.department_id = User.find_by_id(session[:user_id]).department_id
		@ticket.upload_id = 1
		@ticket.save
		
		@assign = Assignment.new
		@assign.user_id = session[:user_id]
		@assign.ticket_id = @ticket.id
		@assign.isOwner = true
		@assign.save
		redirect_to ticket_path(@ticket)
	end
	
	def update
		user_ids = params[:ticket][:user_tokens].split(",")
		#ActiveRecord::Base.connection.execute("DELETE from assignments where ticket_id = '#{params[:id]} ' and isOwner = false")
		user_ids.each do | user_id |
			@assign = Assignment.new
			@assign.user_id = user_id
			@assign.ticket_id = params[:id]
			@assign.isOwner = false
			@assign.save
		end
		@ticket = Ticket.find(params[:id])
		@ticket.status_id = params[:ticket][:status_id]
		@ticket.save
		redirect_to ticket_path(params[:id])
	end
	
	
end
