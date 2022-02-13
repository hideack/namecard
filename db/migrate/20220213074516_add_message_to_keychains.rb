class AddMessageToKeychains < ActiveRecord::Migration[6.0]
  def change
    add_column :keychains, :message, :string
  end
end
