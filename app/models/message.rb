class Message < ApplicationRecord
  belongs_to :messagable, polymorphic: true
  belongs_to :author, class_name: 'User'
end
