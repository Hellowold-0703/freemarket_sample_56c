class UsersController < ApplicationController

  def index
   @user = current_user
  end

  def logout

  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:family_name, :first_name, :family_furigana, :first_furigana, :birth_year, :email, :image)
  end
end
