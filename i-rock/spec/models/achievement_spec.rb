require 'rails_helper'

RSpec.describe Achievement, type: :model do

  describe 'validations' do
    it {should validate_presence_of(:title)}
    it {should validate_uniqueness_of(:title).scoped_to(:user_id).with_message("you cannot have two achievements with same title")}
    it {should validate_presence_of(:user)}
    it {should belong_to(:user)}
  end

  it 'converts markdown to html' do
    achievement = Achievement.new(description: 'Awesome **thing** I *actually* did')
    expect(achievement.description_html).to include('<strong>thing</strong>')
    expect(achievement.description_html).to include('<em>actually</em>')
  end

  it 'has silly title' do
    achievement = Achievement.new(title: "New Achievement", user: FactoryGirl.create(:user, email: 'test@test.com'))
    expect(achievement.silly_title).to eq('New Achievement by test@test.com')
  end

  it 'only fetches achievements which title starts from provided letter' do
    user = FactoryGirl.create(:user)
    achievement1 = FactoryGirl.create(:public_achievement, title: 'Read a book', user: user)
    achievement2 = FactoryGirl.create(:public_achievement, title: 'Passed an exam', user: user)
    expect(Achievement.by_letter("R")).to eq([achievement1])
    expect(Achievement.by_letter("R")).not_to include(achievement2)
  end

  it 'sorts achievements by user emails' do
    albert = FactoryGirl.create(:user, email: 'albert@email.com')
    rob = FactoryGirl.create(:user, email: 'rob@email.com')
    achievement1 = FactoryGirl.create(:public_achievement, title: 'Read a book', user: rob)
    achievement2 = FactoryGirl.create(:public_achievement, title: 'Rocked it', user: albert)
    expect(Achievement.by_letter("R")).to eq([achievement2, achievement1])
  end
end
