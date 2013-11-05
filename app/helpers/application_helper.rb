module ApplicationHelper
	def	sortable(column, title = nil)
		title ||=column.titleize
		direction = column == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"
		link_to title, params.merge(:sort => column, :direction => direction, :page => nil)
	end
	
	def check_user_exists
     @myUser = User.find_by_seKey(this.seKey)
     if @myUser != nil
       #
	 else 
		redirect_to home_path
     end
  end
  
  def hyperlink_parser(string)
	return string.gsub(/(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/) {|x| is_tld?(x) ? "<a href='#{x}'>#{x}</a>" : x}
  end
  
end
