class TagsController < ApplicationController
	before_filter :authenticate_user!

	def show
		@tag = Tag.find_by(slug: params[:slug])
		@links = Link.where("tags.id" => @tag.id).page(params[:page])
	end

	def index
		@tags = Tag.asc(:slug).page(params[:page]).per(100)
	end
end
