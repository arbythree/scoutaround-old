require 'rails_helper'

RSpec.describe Registration, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:registration)).to be_valid
  end

  it 'event has person as a registrant' do
    registration = FactoryBot.create(:registration)
    event = registration.event
    person = registration.person
    expect(event.registrants).to include(person)
  end
end
