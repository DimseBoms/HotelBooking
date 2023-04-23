class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.references :hotel, null: false, foreign_key: true
      t.date :arrival_date
      t.date :departure_date
      t.integer :no_of_rooms

      t.timestamps
    end
  end
end
