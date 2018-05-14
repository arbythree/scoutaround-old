require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:user)).to be_valid
  end

  it 'requires associated Person' do
    expect(FactoryBot.build(:user, person_id: nil)).not_to be_valid
  end
end
