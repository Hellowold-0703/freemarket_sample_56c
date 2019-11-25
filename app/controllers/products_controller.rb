class ProductsController < ApplicationController
  
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
    @product = Product.find(params[:id])
    @seller = Seller.find_by(product_id: @product.id)
    @sellers = Seller.where("user_id = ?", @seller.user_id).limit(6)
    @products = Product.limit(6)
    @nike_products = @products.where("brand_id = ?", @product.brand_id)
  end

  private

  def params_product
    params.require(:product).permit(:name, :explanation, :status, :shipping_charge, :shipping_area, :days_before_shipment, :selling_prime, :shipping_method, :likes_count, :category_id, :brand_id, {images: []})
  end
end
