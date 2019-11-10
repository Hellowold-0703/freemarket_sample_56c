class LikesController < ApplicationController
  before_action :set_variables

  def like
    like = @user.likes.new(product_id: @product.id)
    like.save
  end

  def unlike
    like = @user.likes.find_by(product_id: @product.id)
    like.destroy
  end

  private

  def set_variables
    @user = User.find(1)
    @product = Product.find(params[:product_id])
    @id_name = "#like-link-#{@product.id}"
  end
end
