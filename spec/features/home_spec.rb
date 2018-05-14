require 'rails_helper'

RSpec.feature "Home page", :type => :feature do
  it 'works' do
    user = FactoryBot.create(:user)
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: 'goscoutaround'
    click_on 'Log in'
    expect(page).to have_current_page(root_url)
  end
end
