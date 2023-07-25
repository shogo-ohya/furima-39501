class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :require_login, only: [:new]

  
  private

  def require_login
    unless user_signed_in?
      redirect_to new_user_session_path, alert: "ログインしてください"
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :email, :password, :password_confirmation,:first_name,:last_name,:first_name_kana,:last_name_kana,:birthday])
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == 'admin' && password == '2222'
    end
  end
end