class AddpaymentTouses < ActiveRecord::Migration[5.0]
  def change
    add_column :users,:payment_carc_expire,       :integer
    add_column :users,:payment_card_security_code,:integer
    add_column :users,:exp_month,                 :integer
    add_column :users,:exp_year,                  :integer
  end
end
