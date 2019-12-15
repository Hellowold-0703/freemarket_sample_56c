class RemoveProductImages < ActiveRecord::Migration[5.0]
  def change
    drop_table :product_images
  end
end
