class LinksController < ApplicationController
	before_filter :authenticate_user!
	def create
		tag_names = params[:link].delete 'tags'
		@link = current_user.links.build(params[:link])
		p '----------------------'
		puts tag_names
		tag_names.split(/,/) do |name|
			@link.tags.build Tag.new(name: name)
		end

		if @link.save
			redirect_to :back, notice: "New link has been saved!" 
		else
			redirect_to :back, alert: "Link save error: #{@link.errors.full_messages}" 
		end
	end

	def index
		@links = current_user.links.order_by('id desc').page(params[:page])
	end

	def go
		@link = Link.find params[:id]
		@link.visit!
		redirect_to @link.url
	end
end
