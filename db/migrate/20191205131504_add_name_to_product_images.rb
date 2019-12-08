class AddNameToProductImages < ActiveRecord::Migration[5.0]
  def change
    add_column :product_images, :name, :string, null:false
  end
end
