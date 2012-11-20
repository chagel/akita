class FavoritesController < ApplicationController
	before_filter :authenticate_user!
	
	def index
		@links = Kaminari.paginate_array(current_user.favorites.order_by('id desc').map(&:link)).page(params[:page])
	end

	def create
		unless params[:id]
			render :json => {:error => 'params is missing' }.to_json
		else
			favs = current_user.favorites.where(link_id: params[:id])
			if favs.present?
				favs.destroy_all
				action = :destroy
			else
				current_user.favorites.create(link_id: params[:id]) 
				action = :create
			end
			render :json => {:action => action }.to_json
		end
	end
end
