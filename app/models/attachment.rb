class Attachment < ApplicationRecord
  belongs_to :attachable, polymorphic: true
  include AttachmentUploader.attachment(:file)
end
