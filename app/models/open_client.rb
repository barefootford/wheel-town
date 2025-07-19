class OpenClient
  def self.analyze_trip(image_url_or_base64)
    client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))
    
    messages = [
      {
        role: "system",
        content: "You are analyzing an image from a bike lane. Extract information about the vehicle and rider."
      },
      {
        role: "user",
        content: [
          {
            type: "text",
            text: "This is an image of a user in a bike lane riding a bike, scooter, or similar vehicle. Please analyze the image and return JSON with the following attributes: vehicle_type (bike, ebike, cargo bike, scooter, etc.), gender_of_clothing (masculine, feminine, or neutral based on clothing style), clothing_type (athletic like lycra/bike jersey or casual), passenger_count (number of passengers, e.g., if a parent is riding with a child), wearing_helmet (true or false), electric (true if the vehicle appears to be electric-powered, such as an e-bike or electric scooter, false otherwise), and child (true if the primary rider appears to be a child based on their size and appearance, false if they appear to be an adult)."
          },
          {
            type: "image_url",
            image_url: {
              url: image_url_or_base64.start_with?("data:") ? image_url_or_base64 : "data:image/jpeg;base64,#{image_url_or_base64}"
            }
          }
        ]
      }
    ]
    
    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: messages,
        response_format: {
          type: "json_schema",
          json_schema: {
            name: "bike_trip_analysis",
            strict: true,
            schema: {
              type: "object",
              properties: {
                vehicle_type: {
                  type: "string",
                  description: "Type of vehicle being ridden",
                  enum: ["bike", "ebike", "cargo_bike", "scooter", "skateboard", "other"]
                },
                gender_of_clothing: {
                  type: "string", 
                  description: "Gender presentation based on clothing style",
                  enum: ["masculine", "feminine", "neutral"]
                },
                clothing_type: {
                  type: "string",
                  description: "Type of clothing worn by rider",
                  enum: ["athletic", "casual"]
                },
                passenger_count: {
                  type: "integer",
                  description: "Number of passengers (e.g., child on back)",
                  minimum: 0
                },
                wearing_helmet: {
                  type: "boolean",
                  description: "Whether the primary rider is wearing a helmet"
                },
                electric: {
                  type: "boolean",
                  description: "Whether the vehicle appears to be electric-powered"
                },
                child: {
                  type: "boolean",
                  description: "Whether the primary rider appears to be a child"
                }
              },
              required: ["vehicle_type", "gender_of_clothing", "clothing_type", "passenger_count", "wearing_helmet", "electric", "child"],
              additionalProperties: false
            }
          }
        },
        max_tokens: 300
      }
    )
    
    if response.dig("choices", 0, "message", "content")
      JSON.parse(response.dig("choices", 0, "message", "content"))
    else
      raise "Failed to analyze image: #{response}"
    end
  rescue => e
    Rails.logger.error "OpenAI API error: #{e.message}"
    raise
  end
end