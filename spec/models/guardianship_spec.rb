require 'rails_helper'

RSpec.describe Guardianship, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:guardianship)).to be_valid
  end

  it 'prevents duplicates' do
    guardianship = FactoryBot.create(:guardianship)
    expect(FactoryBot.build(
      :guardianship,
      guardee_id: guardianship.guardee.id,
      guardian_id: guardianship.guardian.id
    )).not_to be_valid
  end

  describe 'relationships' do
    before do
      @guardianship = FactoryBot.create(:guardianship)
      @youth = @guardianship.guardee
      @dad = @guardianship.guardian
    end

    it 'establishes the guardian with the guardee' do
      expect(@youth.guardians).to include(@dad)
    end

    it 'establishes the guardee with the guardian' do
      expect(@dad.guardees).to include(@youth)
    end
  end
end
