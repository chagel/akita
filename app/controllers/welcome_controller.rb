class WelcomeController < ApplicationController
	before_filter :authenticate_user!
	before_filter :redirect_apply

	def index
		@links = Link.order_by('id desc').page(params[:page])
	end

	private
	def redirect_apply
		redirect_to apply_path unless user_signed_in?
	end
end
