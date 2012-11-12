require 'digest/md5'

module UsersHelper
	def render_login_and_signup_link
		if user_signed_in?
			content_tag :div do 
				link_to(current_user.nickname, logout_path, method: 'delete') 
			end
		else
			link_to "login", user_omniauth_authorize_path(:google_oauth2)
		end
	end

	def gravatar_image_url(email, size="50x50")
		hash = Digest::MD5.hexdigest(email.downcase)
		image_tag "http://www.gravatar.com/avatar/#{hash}", size: size
	end
end
