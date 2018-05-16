require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:user)).to be_valid
  end

  it 'has a valid Youth factory' do
    expect(FactoryBot.build(:youth)).to be_valid
  end

  it 'has a valid Adult factory' do
    expect(FactoryBot.build(:adult)).to be_valid
  end
end
