class CreateDailyexcercises < ActiveRecord::Migration[6.1]
  def change
    create_table :dailyexcercises do |t|
      t.datetime :daily
      t.references :kmondai, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
