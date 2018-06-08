require 'rails_helper'

RSpec.describe UserPreference, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:user_preference)).to be_valid
  end

  it 'prevents duplicates' do
    pref = FactoryBot.create(:user_preference)
    dupe = FactoryBot.build(:user_preference, user: pref.user)
    expect(dupe).not_to be_valid
  end
end
