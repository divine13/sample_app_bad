module UsersHelper
	def gravatar_for(user, options = {size: 50})
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		size = options[:size]
		gravatar_url = "divine.jpg?s=#{size}"
		image_tag(gravatar_url,atl: user.name, class: "gravatar")
	end 
end
