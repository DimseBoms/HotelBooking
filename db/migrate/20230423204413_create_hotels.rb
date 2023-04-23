class CreateHotels < ActiveRecord::Migration[7.0]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :city
      t.integer :number_of_rooms
      t.decimal :room_price

      t.timestamps
    end
  end
end
