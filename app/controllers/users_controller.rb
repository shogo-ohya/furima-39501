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
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email)
  end

  
end
