class ChangeColumnToAllowNull < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :family_name,     :string , null: true
    change_column :users, :first_name,      :string , null: true
    change_column :users, :family_furigana, :string , null: true
    change_column :users, :first_furigana,  :string , null: true
    change_column :users, :birth_year,      :string , null: true
  end
end
