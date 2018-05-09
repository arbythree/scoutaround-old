class HomeController < ApplicationController
  def index
    @current_user = current_user
    @current_person = current_user.person
  end
end
