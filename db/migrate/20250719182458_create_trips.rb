class CreateTrips < ActiveRecord::Migration[8.0]
  def change
    create_table :trips do |t|
      t.string :vehicle
      t.string :clothing
      t.string :gender_of_clothing
      t.integer :passenger_count
      t.boolean :wearing_helmet
      t.references :recording, null: false, foreign_key: true

      t.timestamps
    end
  end
end
