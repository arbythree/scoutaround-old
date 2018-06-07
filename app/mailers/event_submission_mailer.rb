class EventSubmissionMailer < ApplicationMailer
  def document_receipt_email
    @user = params[:user]
    return if @user.anonymous_email?
    mail(to: @user.email)
  end
end
