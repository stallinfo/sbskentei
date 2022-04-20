class CreateSystemNames < ActiveRecord::Migration[6.1]
  def change
    create_table :system_names do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :system_names, [:content, :created_at]
  end
end
