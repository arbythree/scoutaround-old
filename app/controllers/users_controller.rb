class UsersController < AuthenticatedController
  before_action :find_user
  layout 'narrow'

  def show
  end

  def edit
  end

  def update
    @user.assign_attributes(user_params)
    if @user.save!
      flash[:notice] = 'Your profile has been updated'
      redirect_to root_path
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :nickname,
      :email,
      :phone,
      :avatar,
      :date_of_birth
    )
  end
end
