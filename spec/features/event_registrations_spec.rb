require 'rails_helper'

RSpec.feature "Event registration features", :type => :feature do
  before do
    sign_in # see spec/support/feature_spec_helper
    visit unit_event_event_registrations_path(@unit, @event)
  end

  it 'shows all registrations' do
    expect(page).to have_current_path(unit_event_event_registrations_path(@unit, @event))
  end

  it 'shows a single registration' do
    visit unit_event_event_registration_path(@unit, @event, @registration)
    expect(page).to have_current_path(unit_event_event_registration_path(@unit, @event, @registration))
  end

  describe 'manipulates registrations' do
    before do
      @new_user = FactoryBot.create(:youth)
      Membership.create(user: @new_user, unit: @unit)
      click_on I18n.t('registrations.add')
      find(:css, 'input[type="checkbox"]').set(true)
      click_on I18n.t('registrations.add')
    end

    it 'adds a registration' do
      expect(page).to have_current_path(unit_event_event_registrations_path(@unit, @event))
      # expect(page).to have_content(@new_user.full_name)
    end

    it 'removes a registration' do
      visit unit_event_event_registration_path(@unit, @event, @registration)
      count = @event.event_registrations.count
      click_on I18n.t('registrations.destroy')
      @event.reload
      expect(@event.event_registrations.count).to eq(count - 1)
    end
  end
end
