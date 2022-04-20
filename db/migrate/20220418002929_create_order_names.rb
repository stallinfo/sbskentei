class CreateOrderNames < ActiveRecord::Migration[6.1]
  def change
    create_table :order_names do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :system_name, null: false, foreign_key: true

      t.timestamps
    end
    add_index :order_names, [:system_name_id, :content]
  end
end
