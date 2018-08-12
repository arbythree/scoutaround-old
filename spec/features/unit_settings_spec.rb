require 'rails_helper'

RSpec.feature "Unit settings", :type => :feature do
  before do
    sign_in # see spec/support/feature_spec_helper
  end

  it 'navigates to settings page' do
    visit "/#{@unit.id}/settings"
    expect(page).to have_current_path("/#{@unit.id}/settings")
  end
end
