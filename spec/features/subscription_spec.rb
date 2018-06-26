require 'rails_helper'

RSpec.feature "Subscription features", :type => :feature do
  before do
    @user = FactoryBot.create(:adult)
    @unit = FactoryBot.create(:troop)

    @membership = Membership.create(user: @user, unit: @unit, role: :admin)
    visit new_user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: 'goscoutaround'
    click_on I18n.t('auth.sign_in')
  end

  it 'visits the subscription page' do
    visit unit_subscription_path(@unit)
    expect(page).to have_current_path(unit_subscription_path(@unit))
  end
end
