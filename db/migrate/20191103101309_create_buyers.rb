class CreateBuyers < ActiveRecord::Migration[5.0]
  def change
    create_table :buyers do |t|
      t.references  :user, foreign_key: true, null: false
      t.references  :product, foreign_key: true, null: false
      t.timestamps
    end
  end
end
