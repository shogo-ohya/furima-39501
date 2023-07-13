class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :first_name, :last_name, :first_name_kana, :last_name_kana, :birthday)
  end

  def account_update_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :current_password, :first_name, :last_name, :first_name_kana, :last_name_kana, :birthday)
  end
end
