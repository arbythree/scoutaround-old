class MagicLinksController < ApplicationController
  layout 'magic_links'

  def show
    @magic_link = MagicLink.find_by(token: params[:id])

    if @magic_link.expired?
      respond_to do |format|
        format.html
      end
    else
      MagicLinkMailer.sender_redemption_email(@magic_link).deliver_later
      @magic_link.update_attributes(redeemed_at: Time.now)

      respond_to do |format|
        format.html
        format.pdf
        format.zip
      end
    end
  end
end
