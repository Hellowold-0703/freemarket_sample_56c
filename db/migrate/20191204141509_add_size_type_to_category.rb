class AddSizeTypeToCategory < ActiveRecord::Migration[5.0]
  def change
    add_reference :categories, :size_type, foreign_key: true
  end
end
