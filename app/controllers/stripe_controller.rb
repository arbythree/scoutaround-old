class StripeController < AuthenticatedController
  layout 'narrow'

  #
  # this is the return route from Stripe Connect.
  # See https://stripe.com/docs/connect/quickstart for more
  #
  def payment_setup
    auth_code = params[:code]
    conn = Faraday.new(url: 'https://connect.stripe.com')
    data = {
      client_secret: ENV['STRIPE_SECRET_KEY'],
      code: auth_code,
      grant_type: 'authorization_code'
    }

    response = conn.post '/oauth/token', data
    json = JSON.parse(response.body)
    @unit = @current_user.units.find(session[:unit_id])
    @unit.stripe_user_id = json['stripe_user_id']
    @unit.save

    flash[:notice] = t('units.success.payment_setup')
    session[:unit_id] = nil
    redirect_to unit_unit_path(@unit)
  end

  def show
    @unit = Unit.find(params[:unit_id])
    session[:unit_id] = @unit.id # kludge alert: the Stripe callback URL can't be dynamic, so we need to cache the unit we're setting up
  end
end
