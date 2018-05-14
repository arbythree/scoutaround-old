require 'rails_helper'

RSpec.describe EventSubmission, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:event_submission)).to be_valid
  end
end
