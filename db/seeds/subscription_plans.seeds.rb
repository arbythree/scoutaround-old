SubscriptionPlan.where(sku: 'annual', display_name: 'Annual', internal_name: 'Annual', frequency: 'annual', price: 9900).first_or_create
SubscriptionPlan.where(sku: 'monthly', display_name: 'Monthly', internal_name: 'Annual', frequency: 'monthly', price: 9900).first_or_create
SubscriptionPlan.where(sku: 'complimentary', display_name: 'Complimentary', internal_name: 'Complimentary', frequency: 'perpetual', price: 0).first_or_create
