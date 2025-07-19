# Example usage of OpenClient

# To analyze a trip image from a URL:
# analysis = OpenClient.analyze_trip("https://example.com/bike-image.jpg")

# To analyze a trip image from base64 data:
# base64_image = Base64.strict_encode64(File.read("path/to/image.jpg"))
# analysis = OpenClient.analyze_trip(base64_image)

# The analysis will return a hash like:
# {
#   "vehicle_type" => "bike",
#   "gender_of_clothing" => "feminine",
#   "clothing_type" => "athletic",
#   "passenger_count" => 1,
#   "wearing_helmet" => true,
#   "electric" => false,
#   "child" => false
# }

# Usage in Trip model:
# trip = Trip.find(1)
# result = trip.analyze_image
# puts result["vehicle_type"]      # => "bike"
# puts result["wearing_helmet"]    # => true