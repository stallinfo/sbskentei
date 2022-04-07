class CreateFkaitos < ActiveRecord::Migration[6.1]
  def change
    create_table :fkaitos do |t|
      t.references :fukusu, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :kmondai, null: false, foreign_key: true
      t.references :fmondai, null: false, foreign_key: true
      t.integer :answer
      t.boolean :kettei
      t.boolean :correct
      t.string :answerstring

      t.timestamps
    end
  end
end
