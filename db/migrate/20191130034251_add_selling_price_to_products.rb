class AddSellingPriceToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :selling_price, :integer, null: false
  end
end
