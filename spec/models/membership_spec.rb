require 'rails_helper'

RSpec.describe Membership, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:membership)).to be_valid
  end

  it 'prevents duplicates' do
    membership = FactoryBot.create(:membership)
    expect(FactoryBot.build(
      :membership,
      user_id: membership.user.id,
      unit_id: membership.unit.id)
    ).not_to be_valid
  end

  it 'unit has user as a member' do
    membership = FactoryBot.create(:membership)
    unit = membership.unit
    user = membership.user
    expect(unit.members).to include(user)
  end

  it 'user is a member of unit' do
    membership = FactoryBot.create(:membership)
    unit = membership.unit
    user = membership.user
    expect(user.units).to include(unit)
  end
end
