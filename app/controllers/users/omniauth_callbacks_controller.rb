class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def google_oauth2
		# raise request.env["omniauth.auth"].to_yaml
    auth = request.env["omniauth.auth"]
    email = auth['info']['email']
	  existed_auth = Authentication.where(:provider => auth['provider'], :uid => auth['uid']).first
    begin
      if existed_auth.present?
        user = existed_auth.user
      elsif User.where(email: email).exists?
        # TODO: oauth2 bind to email account
        redirect_to login_url, alert: "Email address [#{email}] has been registered already." and return
      else
        user = User.create_with_omniauth(auth)
      end

      if !user.persisted?
        redirect_to login_url, alert: "error when creating credentials: #{user.errors.full_messages}"
      else
        sign_in_and_redirect user, :event => :authentication
      end
    rescue
      redirect_to login_url, alert: "error when creating credentials: #{$!.message}"
    end
	end
end