class ChangeDataImageToProductImages < ActiveRecord::Migration[5.0]
  def change
    change_column :product_images, :image, :binary
  end
end
