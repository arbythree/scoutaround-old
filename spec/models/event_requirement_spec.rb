require 'rails_helper'

RSpec.describe EventRequirement, type: :model do
  it 'has a valid DocumentEventRequirement factory' do
    expect(FactoryBot.create(:document_event_requirement)).to be_valid
  end

  it 'has a valid PaymentEventRequirement factory' do
    expect(FactoryBot.create(:payment_event_requirement)).to be_valid
  end
end
