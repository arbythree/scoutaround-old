class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :select_layout

  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    klass.new(object, view_context)
  end

  def select_layout
    user_signed_in? ? 'application' : 'unauthenticated'
  end
end
