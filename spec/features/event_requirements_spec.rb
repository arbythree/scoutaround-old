require 'rails_helper'

RSpec.feature "Event requirements features", :type => :feature do
  before do
    @user = FactoryBot.create(:adult)
    @unit = FactoryBot.create(:troop)
    @event = FactoryBot.create(:event, unit: @unit)
    Membership.create(user: @user, unit: @unit, role: :admin)
    visit new_user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: 'goscoutaround'
    click_on 'Log in'
    visit unit_event_event_registrations_path(@unit, @event)
  end

  it 'adds a new event requirement' do
    click_on I18n.t('events.add_requirement')
    requirement_name = "I can't believe it's not butter"
    fill_in :event_requirement_description, with: requirement_name
    click_on 'add'
    expect(page).to have_content(requirement_name)
  end
end
