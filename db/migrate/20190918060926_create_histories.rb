class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.integer :user_id
      t.integer :tabaco_id
      t.integer :price
      t.integer :volume
      t.string  :brand
      t.timestamps
    end
  end
end
