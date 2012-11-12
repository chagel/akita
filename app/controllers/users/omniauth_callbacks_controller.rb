class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def google_oauth2
		# raise request.env["omniauth.auth"].to_yaml
    auth = request.env["omniauth.auth"]
	  existed_auth = Authentication.where(:provider => auth['provider'], :uid => auth['uid']).first
  	user = existed_auth.present? ? existed_auth.user : User.create_with_omniauth(auth)
  	if !user.persisted?
  		redirect_to root_url, error: "error when creating credentials: #{user.errors.full_messages}"
  	else
  		sign_in_and_redirect user, :event => :authentication
  	end
	 
	end
end