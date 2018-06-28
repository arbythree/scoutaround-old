require 'rails_helper'

RSpec.describe UserPresenter do
  include ActionView::TestCase::Behavior

  it 'shows a full name' do
    user = FactoryBot.build(:user)
    presenter = UserPresenter.new(user, view)
    expect(presenter.display_name).to eq("#{user.first_name} #{user.last_name}")
  end

  it 'shows a full name with post nominal' do
    user = FactoryBot.build(:user_with_post_nominal)
    presenter = UserPresenter.new(user, view)
    expect(presenter.display_name).to eq("#{user.first_name} #{user.last_name}, #{user.post_nominal}")
  end
end
