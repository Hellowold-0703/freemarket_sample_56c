class CreditCardController < ApplicationController
  require "payjp"

  before_action :authenticate_user!

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
        redirect_to action: "show"
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
