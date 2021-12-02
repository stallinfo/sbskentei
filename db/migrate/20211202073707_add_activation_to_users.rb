class AddActivationToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :active, :boolean, default: false
  end
end
