module ApplicationHelper
	def	sortable(column, title = nil)
		title ||=column.titleize
		direction = column == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"
		link_to title, :sort => column, :direction => direction
	end
	
	def check_user_exists
     @myUser = User.find_by_seKey(this.seKey)
     if @myUser != nil
       #
	 else 
		redirect_to home_path
     end
  end
end
