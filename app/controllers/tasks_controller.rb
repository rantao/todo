class TasksController < ApplicationController

	respond_to	:html, :json, :xml

	def index
		@tasks = Task.all
		respond_with(@tasks)
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
		respond_with @task, :location => list_path(@task.list)
	end

	def edit
		@task = Task.find(params[:id])
	end

	def update
		@task = Task.find(params[:id])
		@task.update_attributes(param[:task])
		respond_with(@task) 
	end

	def destroy
		@task = Task.find(params[:id])
		@task.destroy
		respond_with(@task)
	end

end
