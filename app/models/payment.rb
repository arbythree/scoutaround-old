class Payment < ApplicationRecord
  belongs_to :event_submission
end
