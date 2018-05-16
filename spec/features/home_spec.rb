require 'rails_helper'

RSpec.feature "Home page", :type => :feature do
  it 'redirects to unit event page when person only belongs to one unit' do
    user = FactoryBot.create(:user)
    unit = FactoryBot.create(:troop)
    Membership.create(person: user.person, unit: unit)
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: 'goscoutaround'
    click_on 'Log in'
    expect(page).to have_current_path(unit_events_path(unit_id: unit.id))
  end
end
