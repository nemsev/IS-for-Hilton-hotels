class CreateHotelsuppliesrequests < ActiveRecord::Migration
  def change
    create_table :hotelsuppliesrequests do |t|
      t.integer :num
      t.references :stationeryrequest
      t.references :hotelsupply

      t.timestamps
    end
    add_index :hotelsuppliesrequests, :stationeryrequest_id
    add_index :hotelsuppliesrequests, :hotelsupply_id
  end
end
