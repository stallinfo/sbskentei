class AddClassificationNameToKmondai < ActiveRecord::Migration[6.1]
  def change
    add_reference :kmondais, :classification_name, null: false, foreign_key: true
  end
end
