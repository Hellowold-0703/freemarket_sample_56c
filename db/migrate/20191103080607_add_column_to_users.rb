class AddColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :family_name, :string ,null: false
    add_column :users, :first_name, :string ,null: false
    add_column :users, :family_furigana, :string ,null: false
    add_column :users, :first_furigana, :string ,null: false
    add_column :users, :birth_year, :string ,null: false
    add_column :users, :profile, :text
    add_column :users, :image, :string 
    add_column :users, :phone_number, :string ,unique: true
  end
end
