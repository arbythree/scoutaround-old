require 'rails_helper'

RSpec.describe SubscriptionPlan, type: :model do
  it 'prevents duplicate SKUs' do
    plan = FactoryBot.create(:subscription_plan)
    dupe = FactoryBot.build(:subscription_plan, sku: plan.sku)
    expect(dupe).not_to be_valid
  end
end
