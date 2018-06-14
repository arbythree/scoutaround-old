class UsersController < AuthenticatedController
  before_action :find_user

  def show
  end

  def edit
  end

  def update
    @user.assign_attributes(user_params)
    if @user.save!
      flash[:notice] = 'Your profile has been updated'
      redirect_to @user.becomes(User)
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
      :avatar
    )
  end
end
