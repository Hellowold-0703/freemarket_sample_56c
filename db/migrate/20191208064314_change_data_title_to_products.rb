class ChangeDataTitleToProducts < ActiveRecord::Migration[5.0]
  def change
    change_column :products, :status,               :integer
    change_column :products, :shipping_area,        :integer
    change_column :products, :shipping_charge,      :integer
    change_column :products, :days_before_shipment, :integer
    change_column :products, :shipping_method,      :integer
  end
end
