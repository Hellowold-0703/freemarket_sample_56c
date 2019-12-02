class ProductsController < ApplicationController

  require 'payjp'

  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @products = Product.limit(10)
    @mens_products = @products.where('category_id = ?', 14)
    @ladies_products = @products.where('category_id = ?', 1)
    @babies_products = @products.where("category_id = ?", 27)
    
    @chanel_products = @products.where("brand_id = ?", 1)
    @nike_products = @products.where("brand_id = ?", 2)
    @supreme_products = @products.where("brand_id = ?", 4)
    @adidas_products = @products.where("brand_id = ?", 5)
  end
  
  def new
    @product = Product.new
    @seller = Seller.new
  end

  def create
    @product = Product.new(params_product)
      if @product.save
         @seller= Seller.create(user_id: current_user.id,product_id: @product.id)
        redirect_to root_path
      else
        render :new
     end
  end

  def show
    @product = set_product
    @seller = Seller.find_by(product_id: @product.id)
    @sellers = Seller.where("user_id = ?", @seller.user_id).where.not("product_id = ?", @product.id).limit(6)
    @nike_products = Product.where("brand_id = ?", @product.brand_id).limit(6)
  end

  def buy
    @credit_card = current_user.id
    @product = set_product
    card = set_card
    if card.blank?
      redirect_to controller: "credit_card", action: "new"
    else
      Payjp.api_key = set_payjp_private_key
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def pay
    card = set_card
    product = set_product
    @buyer = Buyer.create(user_id: current_user.id, product_id: product.id)
    Payjp.api_key = set_payjp_private_key
    Payjp::Charge.create(
    amount: product.selling_prime,
    customer: card.customer_id,
    currency: 'jpy',
    )
    redirect_to action: 'done'
  end

  def done
    @product = set_product
    @seller = Seller.find_by(product_id: @product.id)
    @sellers = Seller.where("user_id = ?", @seller.user_id).where.not("product_id = ?", @product.id).limit(6)
    @nike_products = Product.where("brand_id = ?", @product.brand_id).limit(6)
  end

  private

  def params_product
    params.require(:product).permit(:name, :explanation, :status, :shipping_charge, :shipping_area, :days_before_shipment, :selling_prime, :shipping_method, :likes_count, :category_id, :brand_id, {images: []})
  end

  def set_payjp_private_key
    payjp_private_key = ENV['PAYJP_PRIVATE_KEY']
  end

  def set_product
    Product.find(params[:id])
  end

  def set_card
    CreditCard.where(user_id: current_user.id).first
  end
end
