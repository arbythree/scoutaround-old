class Units::EventsController < EventsController
  before_action :fetch_view_preference, only: [:index]
  after_action  :store_view_preference, only: [:index]

  private

  def fetch_view_preference
    @view = params[:view] || @current_user.preference_for(key: :unit_events, default: :list)
  end

  def store_view_preference
    @current_user.save_preference_for(key: :unit_events, value: @view)
  end
end
