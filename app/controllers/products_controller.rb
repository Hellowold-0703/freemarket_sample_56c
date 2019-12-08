class ProductsController < ApplicationController

  require 'payjp'

  before_action :set_product, only: [:show, :buy]
  before_action :authenticate_user!, only: [:buy, :pay, :create, :new]
  before_action :category_info_set, only: [:index]
  before_action :brand_info_set, only: [:index]
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
  end
  
  def category_info_set
    array = [1, 14, 27]
    for num in array do
      search_anc = Category.where('ancestry LIKE(?)', "#{num}/%")
      ids = []
      search_anc.each do |i|
        ids << i[:id]
      end
      products = Product.where(category_id: ids).order("id DESC").limit(10)
      instance_variable_set("@category_no#{num}", products)
    end
  end

  def brand_info_set
    array = [1, 2, 4, 5]
    for num in array do
      products = Product.where(brand_id: num).order("id DESC").limit(10)
      instance_variable_set("@brand_no#{num}", products)
    end
  end

  def new
    @product = Product.new
    @product_images = @product.product_images.build
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def get_size
    @sizes = Size.all.where(size_type_id: params[:size_type_id])
  end

  def create
    @product = Product.new(product_params)
    @product_images = ProductImage.new
    @categories = Category.where(id: params[:grandchild_category])
    @product[:category_id] = @categories[0][:id]
    respond_to do |format|
      if @product.save
        num = 0
        image = params[:product_images][:image]
        while num < image.length() do
          @product_images = @product.product_images.build
          @product_images[:image] = image[num]
          @product_images[:name] = "#{@product.id}-#{num}"
          @product_images.save
          File.binwrite("public/images/#{@product.id}-#{num}", image[num].read)
          num += 1
        end
        @seller= Seller.create(user_id: current_user.id,product_id: @product.id)
        format.html{redirect_to root_path}
      else
        format.html{render action: 'new'}
      end
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
    amount: product.selling_price,
    customer: card.customer_id,
    currency: 'jpy',
    )
    redirect_to action: 'done'
    product.update_attributes(display: 1)
  end

  def done
    @product = set_product
    @seller = Seller.find_by(product_id: @product.id)
    @sellers = Seller.where("user_id = ?", @seller.user_id).where.not("product_id = ?", @product.id).limit(6)
    @nike_products = Product.where("brand_id = ?", @product.brand_id).limit(6)
  end

  private

  def product_params
    params.require(:product).permit(:name, :explanation, :status, :shipping_charge, :shipping_area, :days_before_shipment, :selling_price, :shipping_method, :likes_count, :parent_category, :child_category, :grandchild_category, :brand_id, :size_id, product_images_attributes: [:image, :name])
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
