require 'rails_helper'

RSpec.feature "Magic link", :type => :feature do
  before do
    sign_in # see spec/support/feature_spec_helper
  end

  it 'visits the unit magic links page' do
    visit unit_magic_links_path(@unit)
    expect(page).to have_current_path(unit_magic_links_path(@unit))
  end
end
