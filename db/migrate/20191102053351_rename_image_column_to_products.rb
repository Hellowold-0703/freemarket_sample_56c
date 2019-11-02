class RenameImageColumnToProducts < ActiveRecord::Migration[5.0]
  def change
    rename_column :products, :image, :images
  end
end
