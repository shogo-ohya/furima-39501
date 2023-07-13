class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # 保存成功時の処理
      redirect_to root_path, notice: "ユーザーが作成されました。"
    else
      # 保存失敗時の処理
      render :new
    end
  end

  def update
    current_user.update(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation:first_name, :last_name, :first_name_kana, :last_name_kana, :birthday)
  end
end
