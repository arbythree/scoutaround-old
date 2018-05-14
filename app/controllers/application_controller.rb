class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    klass.new(object, view_context)
  end

  def set_current_person
    @current_person = current_user.person
  end
end
