class CreateFmondais < ActiveRecord::Migration[6.1]
  def change
    create_table :fmondais do |t|
      t.references :fukusu, null: false, foreign_key: true
      t.references :kmondai, null: false, foreign_key: true
      t.boolean :kettei

      t.timestamps
    end
  end
end
