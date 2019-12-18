class ProductsController < ApplicationController

  require 'payjp'

  before_action :set_product, only: [:show, :buy, :selling_product, :edit, :destroy]
  before_action :set_search
  before_action :authenticate_user!, only: [:buy, :pay, :create, :new]
  before_action :category_info_set, only: [:index]
  before_action :brand_info_set, only: [:index]
  before_action :authenticate_user!, except: [:index, :show, :search]
  
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
    @categories = Category.where(id: params[:category_id])
    @product[:category_id] = @categories[0][:id]
    if (params[:product][:images] != nil)
      @product.save
      @seller= Seller.create(user_id: current_user.id,product_id: @product.id)
    end
  end
  
  def edit
    @product = Product.find(params[:id])
    gon.product_id = @product[:id]
    @product_images = @product.images
    gon.product_images = @product_images
    @size = Size.find(@product.size_id)
    @size_list = Size.where('size_type_id = ?', "#{@size.size_type_id}")
    @grandchild_category = @product.category
    @child_category = @grandchild_category.parent
    @parent_category = @child_category.parent
    @parent_categories = Category.where("ancestry IS NULL")
    @child_categories = Category.where('ancestry = ?', "#{@grandchild_category.parent.ancestry}")
    @grandchild_categories = Category.where('ancestry = ?', "#{@grandchild_category.ancestry}")
  end

  def update
    @product = Product.find(params[:id])
    if @product.sellers[0].user_id == current_user.id
      @product.update(update_params)
      # if(image_params[:images] != nil)
      #   original_images = @product.images
      #   images = original_images.concat(image_params[:images])
      #   @product.images = images
      #   @product.save!
      # end
    end
  end

  def show
    @product = set_product
    @seller = Seller.find_by(product_id: @product.id)
    @sellers = Seller.where("user_id = ?", @seller.user_id).where.not("product_id = ?", @product.id).limit(6)
    @nike_products = Product.where("brand_id = ?", @product.brand_id).limit(6)
  end

  def destroy
    if @product.destroy
      redirect_to selling_products_users_path
    else
      render :selling_product_product_path
    end
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

  def search
    @search = Product.ransack(params[:q])
    @products = @search.result.order("id DESC")
  end

  def selling_product
    @seller = Seller.find_by(user_id: current_user.id)
  end

  def remove_image_at_index
    @product = Product.find(params[:id])
    index = params[:index].to_i
    original_images = @product.images
    remained_images = original_images.delete_at(index)
    remained_images.try(:remove!)
    @product.update(images: remained_images)
  end

  private

  def product_params
    params.require(:product).permit(:name, :explanation, :status, :shipping_charge, :shipping_area, :days_before_shipment, :selling_price, :shipping_method, :likes_count, :category_id, :brand_id, :size_id, {images: []})
  end

  def update_params
    params.require(:product).permit(:name, :explanation, :status, :shipping_charge, :shipping_area, :days_before_shipment, :selling_price, :shipping_method, :likes_count, :category_id, :brand_id, :size_id)
  end

  def image_params
    params.require(:product).permit(images: [])
  end

  def set_payjp_private_key
    payjp_private_key = ENV['PAYJP_PRIVATE_KEY']
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_card
    CreditCard.where(user_id: current_user.id).first
  end

  def set_search
    @search = Product.ransack(params[:q])
    @products = @search.result(distinct: true)
  end

  def search_params
    params.require(:q).permit(:name_cont)
  end
end