class AddnicknameTousers < ActiveRecord::Migration[5.0]
  def change     
    add_column :users,:nickname,           :string
    add_column :users,:birth_month,        :integer
    add_column :users,:birth_day,          :integer

  end
end
