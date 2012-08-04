class ListsController < ApplicationController

	respond_to :html, :json, :xml 

	def index
		@lists = List.all
		respond_with(@lists)
	end


	def show
		@list = List.find(params[:id])
		@task = Task.new
		@task.list_id = @list.id
		@task.completed = false
		respond_with @list
	end


	def new
		@list = List.new
	end


	def create
		@list = List.new(params[:list])
		puts params[:list]
		@list.save
		respond_with @list, :location => list_path(@list)
	end


	def edit

	end


	def update

	end


	def destroy
		@list = List.find(params[:id])
		@list.destroy
		respond_with @list, :location => lists_path
	end


end
