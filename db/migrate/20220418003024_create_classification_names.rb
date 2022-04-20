class CreateClassificationNames < ActiveRecord::Migration[6.1]
  def change
    create_table :classification_names do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :order_name, null: false, foreign_key: true

      t.timestamps
    end
    add_index :classification_names, [:order_name_id, :content]
  end
end
