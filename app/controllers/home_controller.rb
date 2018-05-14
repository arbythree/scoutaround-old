class HomeController < AuthenticatedController
  def index
    @current_user = current_user
    @current_person = current_user.person
  end
end
