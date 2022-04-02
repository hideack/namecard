class CreateTShirts < ActiveRecord::Migration[6.0]
  def change
    create_table :t_shirts do |t|
      t.string :message
      t.integer :pattern

      t.timestamps
    end
  end
end
