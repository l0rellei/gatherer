require "rails_helper"

RSpec.describe Gatherer do 
	let(:gatherer) { Gatherer.new }
	let(:task) { Task.new }

	it "properly handles a blank project" do 
		expect(gatherer.completed_velocity).to eq(0) 
		expect(gatherer.current_rate).to eq(0) 
		expect(gatherer.projected_days_remaining).to be_nan 
		expect(gatherer).not_to be_on_schedule
	end

	it "considers a project with no tasks to be done" do
#		gatherer = Gatherer.new
		expect(gatherer.done?).to be_truthy
	end

	it "knows that a project with an incomplete task is not done" do
#		gatherer = Gatherer.new
#		task = Task.new
		gatherer.tasks << task
		expect(gatherer.done?).to be_falsy
	end

	it "marks a gatherer done if its tasks are done" do
		gatherer.tasks << task
		task.mark_completed
		expect(gatherer).to be_done
	end
	
end

describe "estimates" do
	let(:gatherer) { Gatherer.new }
	let(:newly_done) { Task.new(size: 3, completed_at: 1.day.ago) } 
	let(:old_done) { Task.new(size: 2, completed_at: 6.months.ago) } 
	let(:small_not_done) { Task.new(size: 1) }
	let(:large_not_done) { Task.new(size: 4) }

	before(:example) do
		gatherer.tasks = [newly_done,old_done, small_not_done, large_not_done]
	end

	it "knows its velocity" do
		expect(gatherer.completed_velocity).to eq(3)
	end

	it "knows its rate" do
		expect(gatherer.current_rate).to eq(1.0 / 7)
	end

	it "knows its projected days remaining" do
		expect(gatherer.projected_days_remaining). to eq(35)
	end

	it "knows if it is not on schedule" do
		gatherer.due_date = 1.week.from_now
		expect(gatherer).not_to be_on_schedule
	end

	it "knows if it is on schedule" do
		gatherer.due_date = 6.months.from_now
		expect(gatherer).to be_on_schedule
	end

	it "can calculate total size" do 
		expect(gatherer.total_size).to eq(10)
	end

	it "can calculate remaining size" do
		expect(gatherer.remaining_size).to eq(5)
	end

end


