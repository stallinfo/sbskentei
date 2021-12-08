class AddNumberToKchoices < ActiveRecord::Migration[6.1]
  def change
    add_column :kchoices, :number, :integer
  end
end
