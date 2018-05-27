# Messages can be sent from many contexts, so this is going to be an extra-flexy,
# extra-complicated controller

class MessagesController < AuthenticatedController
  def new
    @message = Message.new
  end

  def create
  end

  private

  def find_unit
    @unit = @current_user.units.find(params[:unit_id]) if params[:unit_id].present?
  end

  def find_event
  end
end
