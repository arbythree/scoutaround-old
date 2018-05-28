class DocumentLibraryItem < ApplicationRecord
  belongs_to :unit
  has_one_attached :document
end
