class Trip < ApplicationRecord
  belongs_to :recording
  has_one_attached :image

  def analyze_image
    # analyze_image_via_chatgpt(self)
  end
end
