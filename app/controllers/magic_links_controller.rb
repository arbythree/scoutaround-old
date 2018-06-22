class MagicLinksController < ApplicationController
  layout 'magic_links'
  before_action :find_magic_link

  def show
    if @magic_link.expired?
      respond_to do |format|
        format.html
      end
    else
      MagicLinkMailer.sender_redemption_email(@magic_link).deliver_later unless @magic_link.redeemed?
      @magic_link.update_attributes(redeemed_at: Time.now)

      # TODO: extract this out and abstract it as it's currently bound to EventRequirements only
      @event_requirement = @magic_link.magic_linkable


      respond_to do |format|
        format.html
        format.pdf do
          exporter = EventRequirementExporter.new(@event_requirement)
          exporter.export_pdf do |data, filename, mime_type|
            send_data data, filename: filename, type: mime_type, disposition: 'attachment'
          end
        end
        format.zip do
          exporter = EventRequirementExporter.new(@event_requirement)
          exporter.export_zip do |data, filename, mime_type|
            send_file data, filename: filename, type: mime_type, disposition: 'attachment'
          end
        end
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
    raise ActionController::RoutingError.new('Not Found') unless @magic_link.present?
  end
end
