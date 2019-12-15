class ChangeDataTitleToProductImage < ActiveRecord::Migration[5.0]
  def change
    def change
      change_column :product_images, :image, :string
    end
  end
end
