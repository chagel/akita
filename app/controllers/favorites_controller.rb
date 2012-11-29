class FavoritesController < ApplicationController
	before_filter :authenticate_user!
	
	def index
		@links = Link.where(:favorites.in => [current_user.id]).desc(:id).page(params[:page])
	end

	def create
		unless params[:id]
			render :json => {:error => 'params is missing' }.to_json
		else
			link = Link.find params[:id]
			if link.favorites.blank? || !link.favorites.include?(current_user.id)
				link.add_to_set :favorites, current_user.id
				action = :create
			else
				link.favorites.delete current_user.id
				action = :destroy
			end
			link.save
			render :json => {:action => action }.to_json
		end
	end
end
