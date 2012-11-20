class ApplicationController < ActionController::Base
  protect_from_forgery
 	before_filter :verify_code


 	private
 	def verify_code
 		if user_signed_in? && current_user.state == 'pending'
 			redirect_to new_invite_path
 		end
 	end
end
