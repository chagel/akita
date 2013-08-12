class SearchController < ApplicationController
	before_filter :authenticate_user!
	
	def tag 
		tags = Tag.where(slug: /#{params[:term]}/).asc(:slug).limit(10)
		render text: tags.map(&:name)
	end
end
