class CreateKenteikaitous < ActiveRecord::Migration[6.1]
  def change
    create_table :kenteikaitous do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :datetest
      t.string :answer
      t.references :kmondai, null: false, foreign_key: true
      t.boolean :correct

      t.timestamps
    end
  end
end
