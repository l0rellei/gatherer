class GatherersController < ApplicationController
	def new
    @gatherer = Gatherer.new
	end

	def index
		@gatherers = Gatherer.all
	end

	def create
		@workflow = CreatesGatherer.new(
			name: params[:gatherer][:name],
			task_string: params[:gatherer][:tasks]) 
		@workflow.create
		if @workflow.success?
			redirect_to gatherers_path
		else
			@gatherer = @workflow.gatherer
			render :new
		end
	end

end
