class AddElectricToTrips < ActiveRecord::Migration[8.0]
  def change
    add_column :trips, :electric, :boolean
  end
end
