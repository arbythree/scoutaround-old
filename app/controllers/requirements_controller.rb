class RequirementsController < AuthenticatedController
  before_action :find_achievable

  def show
  end

  private

  def find_achievable
    @achievable = Achievable.find(params[:id])
  end
end
