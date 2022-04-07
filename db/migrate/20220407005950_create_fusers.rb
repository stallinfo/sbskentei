class CreateFusers < ActiveRecord::Migration[6.1]
  def change
    create_table :fusers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :fukusu, null: false, foreign_key: true
      t.integer :result
      t.boolean :testdone
      t.float :resultfloat

      t.timestamps
    end
  end
end
