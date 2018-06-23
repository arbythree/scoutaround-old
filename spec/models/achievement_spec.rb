require 'rails_helper'

RSpec.describe Achievement, type: :model do
  it 'prevents achievements on virtual requirements' do
    rank        = Rank.create(description: 'I am a rank')
    parent_req  = Requirement.create!(description: 'I have children', achievable: rank)
    child_req   = Requirement.create!(description: 'I am a child', achievable: parent_req)
    user        = FactoryBot.create(:user)

    # these really belong in an achievable_spec, but here they are
    expect(parent_req.concrete?).to be_falsey
    expect(child_req.concrete?).to be_truthy

    achievement = Achievement.new(achievable: parent_req, user: user)
    expect(achievement).not_to be_valid
  end
end
