require 'rails_helper'

RSpec.describe Person, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:person)).to be_valid
  end

  it 'has a valid Youth factory' do
    expect(FactoryBot.build(:youth)).to be_valid
  end

  it 'has a valid Adult factory' do
    expect(FactoryBot.build(:adult)).to be_valid
  end
end
