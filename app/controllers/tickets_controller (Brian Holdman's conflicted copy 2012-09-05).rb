class TicketsController < ApplicationController
	before_filter :logged_in?

	def index
		if admin?
			if params[:sort]
				@tickets = Ticket.order(params[:sort] + " " + params[:direction]).page(params[:page])
			else
				@tickets = Ticket.order('id desc').page(params[:page])
			end
		else
			if params[:sort]
				@tickets = Ticket.where("user_id = ?", session[:user_id]).order(params[:sort] + " " + params[:direction]).page(params[:page])
			else
				@tickets = Ticket.where("user_id = ?", session[:user_id]).order('id desc').page(params[:page])
			end
		end
	end
	
	def show
		@tickets = Ticket.find(params[:id])
		@users = User.find_by_id(@tickets.user_id)
		@response = Response.new
		@response.ticket_id = @tickets.id
		@response.upload_id = 0
		@statuses = Status.all

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
		@ticket.status = 'New'
		@ticket.user_id = 1
		@ticket.save
		redirect_to ticket_path(@ticket)
	end

end
