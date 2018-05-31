class AuthenticatedController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user

  def set_current_user
    logger.info "Devise current_user is #{ current_user }"
    @current_user = current_user
    logger.info "Set current user: #{ @current_user }"
  end
end
