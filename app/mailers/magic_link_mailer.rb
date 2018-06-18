class MagicLinkMailer < ApplicationMailer
  def recipient_notification_email(magic_link, unit)
    @magic_link = magic_link
    @unit       = unit
    mail(to: magic_link.recipient, subject: I18n.t('email.subjects.magic_link', unit: UnitPresenter.unit_display_name(@unit), sender: @magic_link.sender.full_name))
  end
end
