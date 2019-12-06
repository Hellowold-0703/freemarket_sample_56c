class AddcolumnTousers < ActiveRecord::Migration[5.0]
  def change
    add_column :users,:address_last_name,      :string
    add_column :users,:address_first_name,     :string
    add_column :users,:address_last_name_kana, :string
    add_column :users,:address_first_name_kana,:string
    add_column :users,:address_number,         :string
    add_column :users,:address_prefecture,     :string
    add_column :users,:address_name,           :string
    add_column :users,:address_block,          :string
    add_column :users,:address_building,       :string
    add_column :users,:address_phone_number,   :integer
    add_column :users,:introduce,              :text
  end
end
