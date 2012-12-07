#encoding: utf-8

class LinksController < ApplicationController
	before_filter :authenticate_user!
	before_filter :find_link
	layout 'simple', only: :create

	def create
		@link = current_user.links.create(params[:link]) 
		if !@link.errors.blank?
			redirect_to :back, alert: "Link save error: #{@link.errors.full_messages.to_s}" 
		elsif params[:link]['render'] == 'modal'
			redirect_to links_path
		end
	end

	def index
		@links = current_user.links.order_by('id desc').page(params[:page])
	end

	def new
		@link = Link.new(params[:link])
		render layout: nil
	end

	def show
		@link.visit!
		redirect_to @link.url
	end

	def edit
		render layout: nil
	end

	def update
		@link.update_attributes params[:link]
		render layout: nil
	end

	def destroy
		current_user.links.find(params[:id]).destroy
		redirect_to :back, notice: 'Link has been removed permanently.'
	end

	private 
	def find_link
		@link = Link.find(params[:id]) if params[:id]
	end
end
