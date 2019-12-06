class AddcardNumberTousers < ActiveRecord::Migration[5.0]
  def change
    add_column :users,:card_number,:integer
  end
end
