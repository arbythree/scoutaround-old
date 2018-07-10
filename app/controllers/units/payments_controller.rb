class Units::PaymentsController < ApplicationController
  include UnitContext
  
  def index
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    @charges = Stripe::Charge.list({}, stripe_account: @unit.stripe_user_id) if @unit.accepts_payments?
    ap @charges
  end
end
