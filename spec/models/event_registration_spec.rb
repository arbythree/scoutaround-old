require 'rails_helper'

RSpec.describe EventRegistration, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:event_registration)).to be_valid
  end

  it 'prevents duplicates' do
    registration = FactoryBot.create(:event_registration)
    expect(FactoryBot.build(:event_registration, event_id: registration.event_id, user_id: registration.user_id)).not_to be_valid
  end

  it 'event has user as a registrant' do
    registration = FactoryBot.create(:event_registration)
    event = registration.event
    user = registration.user
    expect(event.registrants).to include(user)
  end
end
