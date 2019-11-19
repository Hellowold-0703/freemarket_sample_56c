class CreditCardController < ApplicationController
  require "payjp"

  def new
    gon.payjp_key = ENV['PAYJP_KEY']
    card = CreditCard.where(user_id: current_user.id)
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
    card = CreditCard.where(user_id: current_user.id).first
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
    card = CreditCard.where(user_id: current_user.id).first
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
    payjp_private_key = ENV['PAYJP_PRIVATE_KEY']
  end
end
