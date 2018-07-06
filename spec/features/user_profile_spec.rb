require 'rails_helper'

RSpec.feature "User profile", :type => :feature do
  before do
    sign_in # see spec/support/feature_spec_helper
  end

  it 'visits the profile page' do
    visit edit_user_path(@user)
    expect(page).to have_current_path(edit_user_path(@user))
  end
end
