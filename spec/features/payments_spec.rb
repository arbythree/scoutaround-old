require 'rails_helper'

RSpec.feature "Advancement features", :type => :feature do
  before do
    sign_in # see spec/support/feature_spec_helper
  end

  it 'visits the payments setup page' do
    visit unit_payments_path(@unit)
    expect(page).to have_current_path(unit_payments_path(@unit))
  end
end
