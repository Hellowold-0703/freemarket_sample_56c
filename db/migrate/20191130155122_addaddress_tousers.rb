class AddaddressTousers < ActiveRecord::Migration[5.0]
  def change
    add_column :users,:address_last_name,      :string,null: false
    add_column :users,:address_first_name,     :string,null: false
    add_column :users,:address_last_name_kana, :string, null: false
    add_column :users,:address_first_name_kana,:string, null: false
    add_column :users,:address_number,         :string,null: false
    add_column :users,:address_prefecture,     :string,null: false, default: 0
    add_column :users,:address_name,           :string,null: false
    add_column :users,:address_block,          :string,null: false
    add_column :users,:address_building,       :string
    add_column :users,:address_phone_number,   :integer
    add_column :users,:introduce,              :text
  end
end
