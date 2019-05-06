require "rails_helper"

RSpec.describe "adding a gatherer", type: :system do
	it "allows a user to create a gatherer with tasks" do
		visit new_gatherer_path
		fill_in "Name", with: "Project Runway"
		fill_in "Tasks", with: "Choose Fabric:3\nMake it Work:5" 
		click_on("Create Gatherer")
		visit gatherers_path
		@gatherer = Gatherer.find_by(name: "Project Runway")
		expect(page).to have_selector("#gatherer_#{@gatherer.id} .name", text: "Project Runway")
		expect(page).to have_selector("#gatherer_#{@gatherer.id} .total_size", text: "8")
		# expect(page).to have_content("Project Runway") 
		# expect(page).to have_content(8)
	end 

	it "does not allow a user to create a project without a name" do
		visit new_gatherer_path
		fill_in "Name", with: ""
		fill_in "Tasks", with: "Choose Fabric:3\nMake it Work:5"
		click_on("Create Gatherer")
		expect(page).to have_selector(".new_gatherer")
	end
	
end