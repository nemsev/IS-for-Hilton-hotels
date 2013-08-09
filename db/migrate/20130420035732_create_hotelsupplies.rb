class CreateHotelsupplies < ActiveRecord::Migration
  def change
    create_table :hotelsupplies do |t|
      t.string :name
      t.integer :num
      t.integer :cost

      t.timestamps
    end
  end
end
