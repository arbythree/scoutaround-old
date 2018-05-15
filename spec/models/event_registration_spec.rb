require 'rails_helper'

RSpec.describe EventRegistration, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:event_registration)).to be_valid
  end

  it 'prevents duplicates' do
    registration = FactoryBot.create(:event_registration)
    expect(FactoryBot.build(:event_registration, event_id: registration.event_id, person_id: registration.person_id)).not_to be_valid
  end

  it 'event has person as a registrant' do
    registration = FactoryBot.create(:event_registration)
    event = registration.event
    person = registration.person
    expect(event.registrants).to include(person)
  end
end
