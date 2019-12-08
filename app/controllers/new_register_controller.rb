class NewRegisterController < ApplicationController
  def index
    @user = User.new
  end

  def phone_number
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confimation] = user_params[:password_confimation]
    session[:family_name] = user_params[:family_name] 
    session[:first_name] = user_params[:first_name]
    session[:family_furigana] = user_params[:family_furigana]
    session[:first_furigana] = user_params[:first_furigana]
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
    @user = User.new(       
    nickname:                    session[:nickname],
    email:                       session[:email], 
    password:                    session[:password], 
    password_confirmation:       session[:password_confirmation], 
    family_name:                   session[:family_name], 
    first_name:                  session[:first_name],
    family_furigana:              session[:family_furigana], 
    first_furigana:             session[:first_furigana],
    birthdate_year:              session[:birthdate_year], 
    birthdate_month:             session[:birthdate_month], 
    birthdate_day:               session[:birthdate_day],
    phone_number:                session[:phone_number],
    address_last_name:           session[:address_last_name], 
    address_first_name:          session[:address_first_name],
    address_last_name_kana:      session[:address_last_name_kana], 
    address_number:              session[:address_number], 
    address_prefecture:          session[:address_prefecture], 
    address_name:                session[:address_name], 
    address_block:               session[:address_block], 
    address_building:            session[:address_building], 
    address_phone_number:        session[:address_phone_number],
    card_number:                 user_params[:card_number],
    payment_carc_expire:         user_params[:payment_carc_expire], 
    payment_card_security_code:  user_params[:payment_card_security_code],
    exp_month:                   user_params[:exp_month], 
    exp_year:                    user_params[:exp_year], 
    )
    if @user.save 
      session[:id] = @user.id
      redirect_to complete_new_register_index_path
          else
          
           redirect_to root_path
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
      :password,
      :password_confimation,
      :family_name,
      :first_name,
      :family_furigana,
      :first_furigana,
      :birthdate_year,
      :birthdate_month,
      :birthdate_day,
      :phone_number,
      :address_first_name,
      :address_last_name,
      :address_last_name_kana,
      :address_first_name_kana, 
      :address_number,
      :address_prefecture,
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
