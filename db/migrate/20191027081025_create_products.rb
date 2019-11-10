class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string     :name,                 null: false, index: true
      t.text       :image,                null: false
      t.text       :explanation,          null: false
      t.string     :status,               null: false
      t.string     :shipping_charge,      null: false
      t.string     :shipping_area,        null: false
      t.string     :days_before_shipment, null: false
      t.integer    :selling_prime,        null: false
      t.string     :shipping_method,      null: false
      t.timestamps
    end
  end
end