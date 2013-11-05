module UsersHelper

	def avatar_url(seKey)
		default_url = u "http://wdsprod.semo.edu/help/assets/gravatar.jpg"
		gravatar_ID = Digest::MD5.hexdigest("#{seKey}@semo.edu".downcase)
		"http://gravatar.com/avatar/#{gravatar_ID}.png?d=#{default_url}"
	end
	
end
