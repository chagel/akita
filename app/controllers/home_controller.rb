class HomeController < ApplicationController
	before_filter :redirect_apply

	def lists
		@lists = List.order_by('id desc').page(params[:page])
	end

	def links
		@links = Link.order_by('id desc').page(params[:page])
	end

	private
	def redirect_apply
		redirect_to apply_path unless user_signed_in?
	end
end
