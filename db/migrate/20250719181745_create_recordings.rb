class CreateRecordings < ActiveRecord::Migration[8.0]
  def change
    create_table :recordings do |t|
      t.date :date
      t.time :time
      t.string :gps_coordinates
      t.string :address
      t.string :city
      t.string :state
      t.string :title
      t.string :recorder_name

      t.timestamps
    end
  end
end
