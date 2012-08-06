# we are going to eat that api yo!

require 'addressable/uri'
require 'json'
require 'rest_client'

##### THINGS WE WANT TO MAKE AVAILABLE ######
# Lists of all to dos [titles]
# All tasks [items] in a list
# What list an item belongs to
# What tasks [items] have been completed
# Adding a new List
# Adding a new Task
# Complete or undoing a Task
# Deleting a Task
# Deleting a list

class ApiEater

	HOST = "localhost:3000"
	@list_id = 1


	def run
		puts ""
		puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
		puts "So you like to organize ALLTHETHINGS huh??"
		puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
		puts ""
		command = ""
		puts "Here are all your lists of things to do!"
		puts ""
		#call the get_lists method to return all the lists
		puts get_lists
		puts ""
        while command != "q"
			printf "Would you like to VIEW a list or CREATE a list?"
			puts ""
			command = gets.chomp
			case command
			  when "view" 
			  	printf "Which list number do you want to view?"
			  	puts ""
			  	input = gets.chomp
			  	puts ""
			  	title = get_list_title(input)
			  	puts "The tasks list for #{title}:"
			  	#call the get_list method to return the list of tasks associated with that list
			  	get_tasks(input)
			  	puts ""
			  when "create"
			  	#call the add_list method 
			  	printf "What do you want to call your list?"
			  	puts ""
			  	title = gets.chomp
			  	puts ""
			  	create_new_list(title) 
			  	printf "Your list: #{title} has been created"
			  	puts ""
			  	while command != "done"
			  		printf "Add a task now or type 'done' if no more tasks to add"
			  		puts ""
			  		command = gets.chomp
			  		if command != "done"
				  		item = command
				  		puts "List: #{title}"
				  		get_last_list
				  		create_new_task(item)
				  		puts get_tasks(@list_id)
				  		puts ""
				  	end
			  	end
			  else
			  	puts "pick either 'view' or 'create' please you lazy bum..."
			end
        end
	end

	def parse_response(response)
	  JSON.parse(response, :symbolize_names => true)
	end


	def get_lists
		all_lists = RestClient.get(Addressable::URI.new({
		    :scheme => "http",
		    :host => HOST,
		    :path => "/lists.json"
		  }).to_s)
		parsed_lists = parse_response(all_lists)
		get_lists_titles(parsed_lists)
	end

	def get_lists_titles(lists)
		lists.each do |list|
			puts "#{list[:id]}. #{list[:title]}"
		end
		return ""
	end

	def get_list_title(list_id)
		list = RestClient.get(Addressable::URI.new({
		    :scheme => "http",
		    :host => HOST,
		    :path => "/lists/#{list_id}.json"
		  }).to_s)
		parsed_list = parse_response(list)
		parsed_list[:title]
	end

	def get_last_list
		all_lists = RestClient.get(Addressable::URI.new({
		    :scheme => "http",
		    :host => HOST,
		    :path => "/lists.json"
		  }).to_s)
		parsed_lists = parse_response(all_lists)
		last_list = parsed_lists.last
		@list_id = last_list[:id]
		@list_title = last_list[:title]
		return ""
	end

	def get_tasks(list_id)
		all_tasks = RestClient.get(Addressable::URI.new({
		    :scheme => "http",
		    :host => HOST,
		    :path => "/tasks.json",
		    :query_values => {
		    	:list_id => list_id
		    }
		  }).to_s)
		parsed_tasks = parse_response(all_tasks)
		get_tasks_items(parsed_tasks)
	end



	def get_tasks_items(tasks)
		tasks.each do |task|
			if task[:completed] 
				status = "Done"
			else
				status = "Not completed"
			end
			puts "#{task[:id]}. #{task[:item]} - #{status}"
		end
		return ""
	end

	def create_new_list(title)
	  begin
	    RestClient.post(Addressable::URI.new({
	      :scheme => "http",
	      :host => HOST,
	      :path => "/lists.json"
	    }).to_s, {
	      :list => {
	        :title => title
	      }
	    })
	  rescue RestClient::UnprocessableEntity => e
	    puts e.response
	  end
	end

	def create_new_task(item)
	  begin
	    RestClient.post(Addressable::URI.new({
	      :scheme => "http",
	      :host => HOST,
	      :path => "/tasks.json"
	    }).to_s, {
	      :task => {
	        :item => item,
	        :list_id => @list_id,
	        :completed => false
	      }
	    })
	  rescue RestClient::UnprocessableEntity => e
	    puts e.response
	  end
	end

	def task_belongs_to 
		
	end

	def completed_tasks
		
	end

	def delete_list
		
	end

	def add_task
		
	end

	def change_task_status
		
	end

	def delete_task
		
	end
end

td = ApiEater.new
td.run
