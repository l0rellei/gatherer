class CreatesGatherer 
	attr_accessor :name, :gatherer, :task_string

	def initialize(name: "", task_string: "") 
		@name = name
		@task_string = task_string || ""
		@success = false
	end

	def success?
		@success
	end

	def build
		self.gatherer = Gatherer.new(name: name)
		gatherer.tasks = convert_string_to_tasks 
		gatherer
	end 

	def create 
		build
    result = gatherer.save
    @success = result
	end

	def convert_string_to_tasks 
		task_string.split("\n").map do |one_task|
			title, size_string = one_task.split(":")
			Task.new(title: title, size: size_as_integer(size_string)) 
		end
	end

	def size_as_integer(size_string) 
		return 1 if size_string.blank? 
		[size_string.to_i, 1].max
	end

end
