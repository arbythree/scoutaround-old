#
# an interface for MagicLinks (and perhaps other things) to
# fetch a description of an object as an alternative to .to_s
#
module Describable
  extend ActiveSupport::Concern

  def description
    raise 'Implementation required'
  end
end
