class ProductsController < ApplicationController

  require 'payjp'
  
  def index
    @products = Product.limit(10)
  end
  
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params_product)
      if @product.save
        redirect_to root_path
      else
        render :new
     end
  end

  def show
    @product = Product.find(params[:id])
  end

  def buy
    @product = Product.find(params[:id])
    card = CreditCard.where(user_id: current_user.id).first
    if card.blank?
      redirect_to controller: "credit_card", action: "new"
    else
      Payjp.api_key = set_payjp_private_key
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def pay
    product = Product.find(params[:id])
    card = CreditCard.where(user_id: current_user.id).first
    Payjp.api_key = set_payjp_private_key
    Payjp::Charge.create(
    :amount => product.selling_prime,
    :customer => card.customer_id,
    :currency => 'jpy',
  )
  redirect_to action: 'done'
  end

  private

  def params_product
    params.require(:product).permit(:name, :explanation, :status, :shipping_charge, :shipping_area, :days_before_shipment, :selling_prime, :shipping_method, :likes_count, {images: []})
  end

  def set_payjp_private_key
    payjp_private_key = ENV['PAYJP_PRIVATE_KEY']
  end
end
