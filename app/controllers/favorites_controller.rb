class FavoritesController < ApplicationController
	before_filter :authenticate_user!
	
	def index
		@links = current_user.favorites.order_by('id desc').page(params[:page])
	end

end
