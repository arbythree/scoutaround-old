require 'rails_helper'

RSpec.feature "Unit positions", :type => :feature do
  before do
    sign_in # see spec/support/feature_spec_helper
  end

  it 'navigates to positions page' do
    visit unit_unit_positions_path(@unit)
    expect(page).to have_current_path(unit_unit_positions_path(@unit))
  end
end
