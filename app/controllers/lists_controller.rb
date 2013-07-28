#encoding: utf-8

class ListsController < ApplicationController
	before_filter :authenticate_user!, except: :show
	layout 'simple', only: :create
	layout 'less', only: :show
	before_filter :find_list

	def create
		@list = current_user.lists.create(params[:list])
		if @list.errors.blank?
			redirect_to lists_path
		else
			redirect_to lists_path, alert: "List save error: #{@list.errors.full_messages.to_s}"
		end
	end

	def index
		@lists = current_user.lists.order_by('updated_at desc').page(params[:page])
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
