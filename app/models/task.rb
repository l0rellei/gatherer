class Task < ApplicationRecord
	belongs_to :gatherer
# 	attr_accessor :size, :completed_at

# 	def initialize(options = {}) #give a hash as argument
# 		mark_completed(options[:completed_at]) if options[:completed_at]
# #		@completed = options[:completed]
# 		@size = options[:size]
# 	end

	def mark_completed(date = Time.current)
		self.completed_at = date
	end

	def complete?
		completed_at.present?
	end

	def part_of_velocity?
		return false unless complete?
		completed_at > Gatherer.velocity_length_in_days.days.ago
	end

	def points_toward_velocity
		part_of_velocity? ? size : 0
	end
end