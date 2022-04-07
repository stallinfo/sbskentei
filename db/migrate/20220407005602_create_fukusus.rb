class CreateFukusus < ActiveRecord::Migration[6.1]
  def change
    create_table :fukusus do |t|
      t.references :user, null: false, foreign_key: true
      t.string :fname
      t.integer :numofexam

      t.timestamps
    end
  end
end
