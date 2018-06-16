require 'rails_helper'

RSpec.describe Unit, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:unit)).to be_valid
  end

  it 'requires a number' do
    expect(FactoryBot.build(:unit, number: nil)).not_to be_valid
  end

  # it 'requires a location' do
  #   expect(FactoryBot.build(:unit, location: nil)).not_to be_valid
  # end

  it 'prevents duplicates' do
    unit = FactoryBot.create(:unit)
    expect(FactoryBot.build(:unit, number: unit.number, city: unit.city, state: unit.state)).not_to be_valid
  end
end
