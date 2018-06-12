require 'rails_helper'

RSpec.describe WikiArticle, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:wiki_article)).to be_valid
  end
end
