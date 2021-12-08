class CreateKchoices < ActiveRecord::Migration[6.1]
  def change
    create_table :kchoices do |t|
      t.references :kmondai, null: false, foreign_key: true
      t.string :sentence

      t.timestamps
    end
  end
end
