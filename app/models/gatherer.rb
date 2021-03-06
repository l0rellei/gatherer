class Gatherer
	attr_accessor :tasks, :due_date

	def initialize
		@tasks = []
	end

	def self.velocity_length_in_days
		21
	end

	#refactored to DRY code
	#extracted the incomplete check
	def incomplete_tasks
		tasks.reject(&:complete?)
	end

	def done?
	#	tasks.all?(&:complete?)
		incomplete_tasks.empty?
	end

	def total_size
		tasks.sum(&:size)
	end

	def remaining_size
	#	tasks.reject(&:complete?).sum(&:size)
		incomplete_tasks.sum(&:size)
	end

	def completed_velocity
		tasks.sum(&:points_toward_velocity)
	end

	def current_rate
		completed_velocity * 1.0 / Gatherer.velocity_length_in_days
	end

	def projected_days_remaining
		remaining_size / current_rate
	end

	def on_schedule?
		return false if projected_days_remaining.nan?
		(Time.zone.today + projected_days_remaining) <= due_date
	end

end