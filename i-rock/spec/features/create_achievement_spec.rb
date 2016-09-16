require 'rails_helper'
require_relative '../support/new_achievement_form'
require_relative '../support/login_form'

feature 'create new achievement' do
  let(:new_achievement_form) { NewAchievementForm.new }
  let(:login_form) { LoginForm.new }
  let(:user) {FactoryGirl.create(:user)}

  scenario 'create new achievement with date' do
    login_form.visit_page.login_as(user)
    new_achievement_form.visit_page.fill_in_with(
      title: 'Read a book'
    ).submit

    expect(page).to have_content('Achievement has been created')
    expect(Achievement.last.title).to eq('Read a book')
  end

  scenario 'cannot create achievement with invalid data' do
    login_form.visit_page.login_as(user)
    new_achievement_form.visit_page.submit

    expect(page).to have_content("can't be blank")
  end
end