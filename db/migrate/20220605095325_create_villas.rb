class CreateVillas < ActiveRecord::Migration[7.0]
  def change
    create_table :villas do |t|
      t.string :name
      t.float :price
      t.string :location
      t.text :address
      t.boolean :is_available
      t.datetime :check_in
      t.datetime :check_out
      t.string :adults_count
      t.float :total_amount

      t.timestamps
    end
  end
end
