class RemoveSellingPrimeToProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :selling_prime, :integer
  end
end
