class EventsController < ApplicationController
  def show
    @current_person = current_user.person
    @event = @current_person.events.find(params[:id])
  end
end
