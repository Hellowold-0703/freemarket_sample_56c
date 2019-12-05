class RemoveCategoryIdToProducts < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :products, :categories
    remove_index :products, :category_id
    remove_reference :products, :category
  end
end
