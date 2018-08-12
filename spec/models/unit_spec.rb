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

  it 'requires expiration date' do
    expect(FactoryBot.build(:unit, subscription_expires_at: nil)).not_to be_valid
  end

  describe 'unit achievements' do
    before do
      @youth = FactoryBot.create(:youth)

      # the kid earns stuff in both cubs and bsa
      @cub_scout_rank = Rank.create(name: 'Weasel', program_code: 'bsa_cub_scouts')
      @cub_scout_rank_achievement = Achievement.create(user_id: @youth.id, achievable_id: @cub_scout_rank.id)

      @merit_badge = MeritBadge.create(name: 'Snorking', program_code: 'bsa')
      @merit_badge_achievement = Achievement.create(user_id: @youth.id, achievable_id: @merit_badge.id)

      # youth is a member of the troop
      @troop = FactoryBot.create(:troop)
      Membership.create(user: @youth, unit: @troop)
    end

    it 'includes the merit badge' do
      expect(@troop.achievements).to include(@merit_badge_achievement)
    end

    it 'excludes the cub rank' do
      expect(@troop.achievements).not_to include(@cub_scout_rank_achievement)
    end
  end
end
