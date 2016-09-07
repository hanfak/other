require 'rails_helper'

feature "Acheivement page" do
  scenario "achievement public page" do
    achievement = FactoryGirl.create(:achievement, title: "go to gym")
    visit("/achievements/#{achievement.id}")

    expect(page).to have_content("go to gym")
  end
end
