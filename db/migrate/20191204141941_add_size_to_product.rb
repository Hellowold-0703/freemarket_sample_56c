class AddSizeToProduct < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :size, foreign_key: true
  end
end
