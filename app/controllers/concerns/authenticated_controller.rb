class AuthenticatedController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_person
end
