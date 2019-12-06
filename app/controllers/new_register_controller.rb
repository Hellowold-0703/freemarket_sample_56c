class NewRegisterController < ApplicationController
  def index
    @user = User.new
  end

  def phone_number
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:last_name] = user_params[:last_name]
    session[:first_name] = user_params[:first_name]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]
    session[:birthdate_year] = user_params[:birthdate_year]
    session[:birthdate_month] = user_params[:birthdate_month]
    session[:birthdate_day]= user_params[:birthdate_day]
    @user = User.new
  end

  def address
    session[:phone_number]= user_params[:phone_number]
    @user = User.new
  end

  def credit
    session[:address_last_name] = user_params[:address_last_name]
    session[:address_first_name] = user_params[:address_first_name]
    session[:address_last_name_kana] = user_params[:address_last_name_kana]
    session[:address_number] = user_params[:address_number]
    session[:address_prefecture] = user_params[:address_prefecture]
    session[:address_name] = user_params[:address_name]
    session[:address_block] = user_params[:address_block]
    session[:address_building] = user_params[:address_building]
    session[:address_phone_number] = user_params[:address_phone_number]
    @user = User.new
  end

  def create
    @user = User.new
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:last_name] = user_params[:last_name]
    session[:first_name] = user_params[:first_name]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]
    session[:birthdate_year] = user_params[:birthdate_year]
    session[:birthdate_month] = user_params[:birthdate_month]
    session[:birthdate_day]= user_params[:birthdate_day]
    session[:phone_number]= user_params[:phone_number]
    session[:address_last_name] = user_params[:address_last_name]
    session[:address_first_name] = user_params[:address_first_name]
    session[:address_last_name_kana] = user_params[:address_last_name_kana]
    session[:address_number] = user_params[:address_number]
    session[:address_prefecture] = user_params[:address_prefecture]
    session[:address_name] = user_params[:address_name]
    session[:address_block] = user_params[:address_block]
    session[:address_building] = user_params[:address_building]
    session[:address_phone_number] = user_params[:address_phone_number]

    if @user.save
      session[:id] = @user.id
      redirect_to root_path
          else
            render '/signup/registration'
          end
        end
  
  def complete
    sign_in User.find(session[:id]) unless user_signed_in?
  end

  private
  def user_params
    params.require(:user).permit(
      :nickname,
      :email,
      :last_name,
      :first_name,
      :first_name_kana,
      :birthdate_month,
      :birthdate_day,
      :phone_number,
      :address_last_name,
      :address_last_name_kana,
      :address_first_name_kana, 
      :address_number,
      :address_name,
      :address_block,
      :address_building,
      :card_number,
      :address_phone_number,
      :payment_carc_expire,
      :payment_card_security_code,
      :exp_month,                 
      :exp_year,                  
    )
 end
end
