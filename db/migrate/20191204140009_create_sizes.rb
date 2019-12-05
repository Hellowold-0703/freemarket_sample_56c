class CreateSizes < ActiveRecord::Migration[5.0]
  def change
    create_table :sizes do |t|
      t.string :name, null: false
      t.references :size_type, null: false
      t.timestamps
    end
  end
end
