require_relative 'open_client'

class Trip < ApplicationRecord
  belongs_to :recording
  has_one_attached :image

  def analyze_image
    return unless image.attached?
    
    # Get the image data as base64
    image_data = image.download
    base64_image = Base64.strict_encode64(image_data)
    
    # Analyze the image using OpenAI
    analysis = OpenClient.analyze_trip(base64_image)
    
    # Update the trip record with the analysis results
    update!(
      vehicle: analysis["vehicle_type"],
      clothing: analysis["clothing_type"],
      gender_of_clothing: analysis["gender_of_clothing"],
      passenger_count: analysis["passenger_count"],
      wearing_helmet: analysis["wearing_helmet"],
      electric: analysis["electric"],
      child: analysis["child"]
    )
    
    analysis
  end
end
