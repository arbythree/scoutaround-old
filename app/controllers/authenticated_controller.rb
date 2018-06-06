class AuthenticatedController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user
  after_action :track_action

  def set_current_user
    @current_user = current_user
  end

  def track_action
    Tracker.track(user: @current_user, event_name: "#{ controller_path }.#{ action_name }", properties: @tracking_properties )
  end
end
