class Units::UnitPositionsController < UnitPositionsController
  include UnitContext

  # override this so that the policy can see the current user's
  # membership context
  def pundit_user
    @current_membership
  end
end
