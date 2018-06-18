class MagicLinkMailer < ApplicationMailer
  #
  # when a link is created, send a note to the recipient
  #
  def recipient_notification_email(magic_link, unit)
    @magic_link = magic_link
    @unit       = unit
    mail(to: magic_link.recipient, subject: I18n.t('email.subjects.magic_link', unit: UnitPresenter.unit_display_name(@unit), sender: @magic_link.sender.full_name))
  end

  #
  # when a link is followed, send a note back to the original sender
  #
  def sender_redemption_email(magic_link)
    @magic_link = magic_link
    mail(to: magic_link.sender.email, subject: I18n.t('email.subjects.magic_link_redemption'))
  end

  #
  # when links expire without being opened, notify senders
  #
  def sender_expiration_email(magic_link)
    @magic_link = magic_link
    mail(to: magic_link.sender.email, subject: I18n.t('email.subjects.magic_link_expiration'))
  end
end
