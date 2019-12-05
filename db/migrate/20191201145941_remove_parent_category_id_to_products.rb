class RemoveParentCategoryIdToProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :parent_category_id
  end
end
