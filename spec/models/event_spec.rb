require 'rails_helper'

RSpec.describe Event, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:event)).to be_valid
  end

  it 'requires a name' do
    expect(FactoryBot.build(:event, name: nil)).not_to be_valid
  end
end
