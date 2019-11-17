class ProductsController < ApplicationController
  
  def index
    @products = Product.limit(10)
    @mens_products = @products.where('category_id = ?', 14)
    @ladies_products = @products.where('category_id = ?', 1)
    @babies_products = @products.where("category_id = ?", 27)

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

  private

  def params_product
    params.require(:product).permit(:name, :explanation, :status, :shipping_charge, :shipping_area, :days_before_shipment, :selling_prime, :shipping_method, :likes_count, :category_id, {images: []})
  end
end
