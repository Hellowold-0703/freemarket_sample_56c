class CreateCreditCards < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_cards do |t|
      t.references :user, null: false
      t.string :customer_id, null: false
      t.string :card_id, null: false
      t.timestamps
    end
  end
end
