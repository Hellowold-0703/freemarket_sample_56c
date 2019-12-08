class RemoveImagesToProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :images, :string
  end
end
