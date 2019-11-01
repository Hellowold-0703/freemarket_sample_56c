class ProductsController < ApplicationController
  
  def index
    Product.all
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
    params.require(:product).permit(:name, :explanation, :status, :shipping_charge, :shipping_area, :days_before_shipment, :selling_prime, :shipping_method, {image: []})
  end
end
