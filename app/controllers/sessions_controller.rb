class SessionsController < ApplicationController
	def create
    # raise request.env["omniauth.auth"].to_yaml
    auth = request.env["omniauth.auth"]
	  user = User.where(:provider => auth['provider'], 
	                    :uid => auth['uid']).first || User.create_with_omniauth(auth)
	  session[:user_id] = user.id
	  if !user.email
	    redirect_to edit_user_path(user), :alert => 'Please enter your email address.'
	  else
	    redirect_to root_url, :notice => 'Signed in!'
	  end
  end
end
