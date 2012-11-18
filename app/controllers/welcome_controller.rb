class WelcomeController < ApplicationController
	before_filter :redirect_apply

	def index
	end

	private
	def redirect_apply
		redirect_to apply_path unless user_signed_in?
	end
end
