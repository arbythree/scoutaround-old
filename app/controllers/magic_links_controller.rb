class MagicLinksController < ApplicationController
  layout 'magic_links'
  before_action :find_magic_link

  def show
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

  def destroy
    @unit = @magic_link.unit
    @magic_link.destroy
    flash[:notice] = I18n.t('magic_links.destroyed')
    redirect_to unit_magic_links_path(@unit)
  end

  private

  def find_magic_link
    @magic_link = MagicLink.find_by(token: params[:id])
  end
end
