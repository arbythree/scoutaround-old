class PaymentsController < UnitContextController
  def index
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    @charges = Stripe::Charge.list({}, stripe_account: @unit.stripe_user_id).data if @unit.accepts_payments?
  end
end
