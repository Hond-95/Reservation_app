class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.datetime :start_ymd
      t.datetime :end_ymd
      t.integer :guests
      t.integer :total_amount
      t.integer :user_id
      t.integer :room_id

      t.timestamps
    end
  end
end
