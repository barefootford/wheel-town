class AddChildToTrips < ActiveRecord::Migration[8.0]
  def change
    add_column :trips, :child, :boolean
  end
end
