class MagicLinksController < ApplicationController
  layout 'magic_links'

  def show
    @magic_link = MagicLink.find_by(token: params[:id])

    if @magic_link.expired?
      respond_to do |format|
        format.html
      end
    else
      respond_to do |format|
        format.html
        format.pdf
        format.zip
      end
    end
  end
end
