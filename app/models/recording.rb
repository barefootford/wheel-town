class Recording < ApplicationRecord
  has_many :trips, dependent: :destroy

  validates :date, presence: true
  validates :time_start, presence: true

  validates :title, presence: true
  validates :recorder_name, presence: true
end
