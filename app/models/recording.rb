class Recording < ApplicationRecord
  has_many :trips, dependent: :destroy
  has_one_attached :cover_image do |attachable|
    attachable.variant :display, resize_to_limit: [1200, 800]
    attachable.variant :thumbnail, resize_to_limit: [400, 300]
  end

  validates :date, presence: true
  validates :time_start, presence: true

  validates :title, presence: true
  validates :recorder_name, presence: true
end
