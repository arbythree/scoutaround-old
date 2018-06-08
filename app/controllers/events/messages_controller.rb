class Events::MessagesController < MessagesController
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

  def find_event
    @event = @unit.events.find(params[:event_id])
  end
end
