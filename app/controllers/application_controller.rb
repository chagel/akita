class ApplicationController < ActionController::Base
  protect_from_forgery
 	before_filter :verify_code
 	rescue_from Exception, :with => :error_handler

 	private
 	def verify_code
 		if user_signed_in? && current_user.state == 'pending'
 			redirect_to new_invite_path
 		end
 	end

 	def error_handler(e)
    if request.path == root_path
      render :text => e.message
    else
      redirect_to root_path, alert: "#{e.message}" 
    end
  end
end
