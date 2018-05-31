class AuthenticatedController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user
  skip_before_action :verify_authenticity_token

  def set_current_user
    logger.info "Devise current_user is #{ current_user }"
    @current_user = current_user
    logger.info "Set current user: #{ @current_user }"
  end
end
