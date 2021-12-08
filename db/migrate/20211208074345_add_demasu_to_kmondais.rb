class AddDemasuToKmondais < ActiveRecord::Migration[6.1]
  def change
    add_column :kmondais, :demasu, :boolean
  end
end
