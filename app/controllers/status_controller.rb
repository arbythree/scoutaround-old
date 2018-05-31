class StatusController < ApplicationController
  before_action :authenticate_user!

  def index
    reset_session
  end
end
