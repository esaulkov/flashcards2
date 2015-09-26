class Dashboard::UsersController < Dashboard::BaseController
  def destroy
    current_user.destroy
    redirect_to login_path, notice: t('messages.user.user_created')
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
