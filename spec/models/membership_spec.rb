require 'rails_helper'

RSpec.describe Membership, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:membership)).to be_valid
  end

  it 'prevents duplicates' do
    membership = FactoryBot.create(:membership)
    expect(FactoryBot.build(
      :membership,
      person_id: membership.person.id,
      unit_id: membership.unit.id)
    ).not_to be_valid
  end

  it 'unit has person as a member' do
    membership = FactoryBot.create(:membership)
    unit = membership.unit
    person = membership.person
    expect(unit.members).to include(person)
  end

  it 'person is a member of unit' do
    membership = FactoryBot.create(:membership)
    unit = membership.unit
    person = membership.person
    expect(person.units).to include(unit)
  end
end
