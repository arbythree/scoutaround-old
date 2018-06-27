class SubscriptionPlan < ApplicationRecord
  validates_uniqueness_of :sku
end
