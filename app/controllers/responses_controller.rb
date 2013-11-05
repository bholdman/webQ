class ResponsesController < ApplicationController

	def new
		@response = Response.new
	end
	
	def create
	
		ticket_id = params[:response].delete(:ticket_id)
		@response = Response.new(params[:response])
		@response.ticket_id = ticket_id
		@response.user_id = session[:user_id] 
		@response.save
		@tickets = Ticket.find(ticket_id)
		TicketMailer.updated(@tickets, session[:username]).deliver

		redirect_to ticket_path(ticket_id)
	end

	
	
end
