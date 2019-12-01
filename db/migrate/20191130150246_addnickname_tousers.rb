class AddnicknameTousers < ActiveRecord::Migration[5.0]
  def change     
    add_column :users,:nickname,               :string,null: false
    add_column :users,:last_name,              :string,null: false
    add_column :users,:first_name,             :string,null: false
    add_column :users,:last_name_kana,         :string,null: false
    add_column :users,:first_name_kana,        :string,null: false
    add_column :users,:birthdate_year,         :integer,null: false
    add_column :users,:birthdate_month,        :integer,null: false
    add_column :users,:birthdate_day,          :integer,null: false
    add_column :users,:phone_number,           :integer,null: false, unique: true
  end
end
