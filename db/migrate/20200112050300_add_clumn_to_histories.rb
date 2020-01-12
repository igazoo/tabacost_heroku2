class AddClumnToHistories < ActiveRecord::Migration[5.2]
  def change
    add_column :histories, :started_at, :datetime
    add_column :histories, :end_date, :datetime
  end
end
