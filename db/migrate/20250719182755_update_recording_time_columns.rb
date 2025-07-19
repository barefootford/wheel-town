class UpdateRecordingTimeColumns < ActiveRecord::Migration[8.0]
  def change
    remove_column :recordings, :time, :time
    add_column :recordings, :time_start, :time
    add_column :recordings, :time_end, :time
  end
end
