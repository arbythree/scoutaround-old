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

  it 'requires first name' do
    expect(FactoryBot.build(:user, first_name: nil)).not_to be_valid
  end

  it 'requires last name' do
    expect(FactoryBot.build(:user, last_name: nil)).not_to be_valid
  end

  it 'requires type' do
    expect(FactoryBot.build(:user, type: nil)).not_to be_valid
  end

  it 'requires email' do
    expect(FactoryBot.build(:user, email: nil)).not_to be_valid
  end
end
