class Home::OauthsController < Home::BaseController
  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if @user = login_from(provider)
      redirect_to trainer_path, notice: (t 'log_in_is_successful_provider_notice',
                                        provider: provider.titleize)
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        redirect_to trainer_path,
                    notice: (t 'log_in_is_successful_provider_notice',
                            provider: provider.titleize)
      rescue
        redirect_to new_user_session_path,
                    alert: (t 'log_in_failed_provider_alert',
                           provider: provider.titleize)
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end
end
