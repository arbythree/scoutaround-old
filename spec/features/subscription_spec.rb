require 'rails_helper'

RSpec.feature "Subscription features", :type => :feature do
  before do
    sign_in # see spec/support/feature_spec_helper
  end

  it 'visits the subscription page' do
    visit unit_subscription_path(@unit)
    expect(page).to have_current_path(unit_subscription_path(@unit))
  end
end
