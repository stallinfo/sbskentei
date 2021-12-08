class AddOriquestionToKmondais < ActiveRecord::Migration[6.1]
  def change
    add_column :kmondais, :oriquestion, :string
  end
end
