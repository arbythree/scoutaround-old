class MagicLinksController < ApplicationController
  layout 'magic_links'

  def show
    @magic_link = MagicLink.find_by(token: params[:id])

    respond_to do |format|
      format.html
      format.pdf
      format.zip
    end
  end
end
