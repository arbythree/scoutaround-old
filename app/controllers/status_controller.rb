class StatusController < ApplicationController
  before_action :authenticate_user!

  def index
    logger.info "Current user is #{ current_user }"
  end
end
