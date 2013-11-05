module TicketsHelper
	
	def avatar_url(seKey)
		default_url = "http://150.201.62.22:3000/assets/gravatar.jpg"
		gravatar_ID = Digest::MD5.hexdigest("#{seKey}@semo.edu".downcase)
		"http://gravatar.com/avatar/#{gravatar_ID}.png&d=#{CGI.escape(default_url)}"
	end
	
	
end
