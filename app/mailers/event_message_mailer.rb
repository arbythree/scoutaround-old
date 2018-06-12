class EventMessageMailer < ApplicationMailer
  def message_notification_email(message, registration)
    @message      = message
    @registration = registration
    @recipient    = @registration.user
    @event        = @message.messagable

    # stand up the Markdown renderer
    options     = { filter_html: true, hard_wrap: true, link_attributes: { rel: 'nofollow', target: "_blank" }, space_after_headers: true, fenced_code_blocks: true }
    extensions  = { autolink: true, superscript: true, disable_indented_code_blocks: true }
    renderer    = Redcarpet::Render::HTML.new(options)
    @markdown   = Redcarpet::Markdown.new(renderer, extensions)

    address = Mail::Address.new @recipient.email
    address.display_name = @recipient.full_name.dup

    mail(
      to: address.format,
      subject: I18n.t('email.subjects.event_message_notification', name: @message.author.short_name, event_name: @event.name)
    )    
  end
end
