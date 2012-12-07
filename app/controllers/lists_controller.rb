#encoding: utf-8

class ListsController < ApplicationController
	before_filter :authenticate_user!
	layout 'simple', only: :create
	before_filter :find_list

	def create
		@list = current_user.lists.create(params[:list])
		redirect_to lists_path
	end

	def index
		@lists = current_user.lists.order_by('id desc').page(params[:page])
	end

	def edit
		render layout: nil
	end

	def update
		@list.update_attributes params[:list]
		render layout: nil
	end

	def destroy
		current_user.lists.find(params[:id]).destroy
		redirect_to :back, notice: 'List has been removed permanently.'
	end

	private 
	def find_list
		@list = List.find(params[:id]) if params[:id]
	end
end
