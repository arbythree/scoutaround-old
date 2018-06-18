require 'rails_helper'

RSpec.describe ApplicationDatum, type: :model do
  it 'prevents duplicates' do
    datum = FactoryBot.create(:application_datum)
    expect(ApplicationDatum.new(key: datum.key, value: 'anything')).not_to be_valid
  end
end
