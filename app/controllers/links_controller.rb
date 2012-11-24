#encoding: utf-8

class LinksController < ApplicationController
	before_filter :authenticate_user!
	layout 'simple', only: :create
	def create
		tag_names = params[:link].delete 'tags'
		@link = current_user.links.build(params[:link])
		tag_names.split(/[,|，]/).each do |name|
			@link.tags << Tag.find_or_initialize_by(name: name.strip)
		end
		if !@link.save
			redirect_to :back, alert: "Link save error: #{@link.errors.full_messages}" 
		elsif params[:link]['render'] == 'modal'
			redirect_to links_path
		end
	end

	def index
		@links = current_user.links.order_by('id desc').page(params[:page])
	end

	def new
		render layout: nil
	end

	def show
		@link = Link.find params[:id]
		@link.visit!
		redirect_to @link.url
	end
end
