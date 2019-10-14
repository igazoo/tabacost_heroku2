class CreateTabacos < ActiveRecord::Migration[5.2]
  def change
    create_table :tabacos do |t|
      t.string :brand
      t.integer :price
      t.integer :volume

      t.timestamps
    end
  end
end
