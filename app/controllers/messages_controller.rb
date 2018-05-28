# Messages can be sent from many contexts, so this is going to be an extra-flexy,
# extra-complicated controller

class MessagesController < AuthenticatedController
  before_action :find_unit
  before_action :find_event

  def new
    @message = Message.new
  end

  def create
    @message = @event.messages.new(message_params) if @event.present?
    @message.author = @current_user
    @message.save
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def find_unit
    @unit = @current_user.units.find(params[:unit_id]) if params[:unit_id].present?
  end

  def find_event
    @event = @unit.events.find(params[:event_id])
  end
end
