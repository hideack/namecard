class RenameTypeToPatternInKeychains < ActiveRecord::Migration[6.0]
  def change
    rename_column :keychains, :type, :pattern
  end
end
