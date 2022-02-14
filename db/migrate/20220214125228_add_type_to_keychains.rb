class AddTypeToKeychains < ActiveRecord::Migration[6.0]
  def change
    add_column :keychains, :type, :integer
  end
end
