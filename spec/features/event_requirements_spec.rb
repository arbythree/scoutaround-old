require 'rails_helper'

RSpec.feature "Event requirements features", :type => :feature do
  before do
    sign_in # see spec/support/feature_spec_helper
    visit event_event_registrations_path(@event)
  end

  it 'shows an event' do
    visit event_path(@event)
  end

  it 'adds a new event requirement' do
    click_on I18n.t('events.add_requirement.document')
    requirement_name = "I can't believe it's not butter"
    fill_in :event_requirement_description, with: requirement_name
    click_on I18n.t('events.accept.document')
    # expect(page).to have_content(requirement_name)
  end

  it 'visits the edit page' do
    requirement = @event.event_requirements.create(type: 'DocumentEventRequirement', description: 'test')
    visit edit_event_requirement_path(requirement)
  end
end
