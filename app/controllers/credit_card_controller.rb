class CreditCardController < ApplicationController
  require "payjp"

  before_action :authenticate_user!

  def index
    @credit_card = current_user.id
    if set_card.blank?
    else
      redirect_to action: "show", id:current_user.id
    end
  end

  def new
    card = set_card
    gon.payjp_key = ENV['PAYJP_KEY']
    redirect_to action: "show" if card.exists?
  end

  def pay
    Payjp.api_key = set_payjp_private_key
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      card: params['payjp-token'],
      )
      @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "show", id:current_user.id
      else
        redirect_to action: "pay"
      end
    end
  end

  def delete
    card = show_card
    if card.blank?
    else
      Payjp.api_key = set_payjp_private_key
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to action: "new"
  end

  def show
    card = show_card
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = set_payjp_private_key
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
      @card_brand = @default_card_information.brand      
      case @card_brand
      when "Visa"
        @card_src = "Visa.png"
      when "JCB"
        @card_src = "JCB.png"
      when "MasterCard"
        @card_src = "MasterCard.png"
      when "American Express"
        @card_src = "AmericanExpress.png"
      when "Diners Club"
        @card_src = "Dinersclub.png"
      when "Discover"
        @card_src = "Discover.png"
      end
    end
  end

  private

  def set_payjp_private_key
    ENV['PAYJP_PRIVATE_KEY']
  end

  def set_card
    CreditCard.where(user_id: current_user.id)
  end

  def show_card
    CreditCard.where(user_id: current_user.id).first
  end
end
