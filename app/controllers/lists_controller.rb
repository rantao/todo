class ListsController < ApplicationController


	def index
		@lists = List.all
	end


	def show
		@list = List.find(params[:id])
		@task = Task.new
		@task.list_id = @list.id
		@task.completed = false
	end


	def new
		@list = List.new
	end


	def create
		@list = List.new(params[:list])
		puts params[:list]
		@list.save
		redirect_to list_path(@list)
	end


	def edit

	end


	def update

	end


	def destroy

	end


end
