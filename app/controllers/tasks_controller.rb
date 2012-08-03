class TasksController < ApplicationController

	def index
		@tasks = Task.all
	end

	def new
		@task = Task.new
	end

	def show
		
	end

	def create
		@task = Task.new(params[:task])
		@task.save
		flash[:message] = "Your task sucks! Add more..."
		redirect_to list_path(@task.list)
	end

end
