require 'rails_helper'

RSpec.describe "Recordings", type: :request do
  describe "GET /recordings/:id" do
    let(:recording) do
      Recording.create!(
        title: "Morning Bike Count",
        date: Date.today,
        time_start: "08:00",
        time_end: "09:00",
        recorder_name: "John Doe",
        address: "123 Main St",
        city: "Portland",
        state: "OR",
        gps_coordinates: "45.5152, -122.6784"
      )
    end

    let!(:trips) do
      [
        recording.trips.create!(
          vehicle: "bicycle",
          wearing_helmet: true,
          electric: false,
          child: false,
          gender_of_clothing: "masculine"
        ),
        recording.trips.create!(
          vehicle: "e-scooter",
          wearing_helmet: false,
          electric: true,
          child: false,
          gender_of_clothing: "feminine"
        ),
        recording.trips.create!(
          vehicle: "skateboard",
          wearing_helmet: false,
          electric: false,
          child: true,
          gender_of_clothing: "neutral"
        )
      ]
    end

    before do
      get recording_path(recording)
    end

    it "returns a successful response" do
      expect(response).to have_http_status(:success)
    end

    it "displays the recording title" do
      expect(response.body).to include("Morning Bike Count")
    end

    it "displays the recording details section" do
      expect(response.body).to include("Recording Details")
    end

    it "displays the recorder name" do
      expect(response.body).to include("John Doe")
    end

    it "displays the recording date" do
      expect(response.body).to include(recording.date.to_s)
    end

    it "displays the start and end times" do
      expect(response.body).to include("08:00")
      expect(response.body).to include("09:00")
    end

    it "displays location information" do
      expect(response.body).to include("123 Main St")
      expect(response.body).to include("Portland")
      expect(response.body).to include("OR")
      expect(response.body).to include("45.5152, -122.6784")
    end

    it "displays location section headers" do
      expect(response.body).to include("Location Details")
      expect(response.body).to include("GPS Coordinates")
      expect(response.body).to include("Address")
      expect(response.body).to include("City")
      expect(response.body).to include("State")
    end

    it "displays the Trip Statistics section" do
      expect(response.body).to include("Trip Statistics")
    end

    it "displays the Total Trips count" do
      expect(response.body).to include("Total Trips")
      expect(response.body).to include("3") # We created 3 trips
    end

    it "displays helmet usage statistics" do
      expect(response.body).to include("Helmet Usage")
      expect(response.body).to include("33.3%") # 1 out of 3 trips with helmet
    end

    it "displays electric vehicle statistics" do
      expect(response.body).to include("Electric Vehicles")
      expect(response.body).to include("33.3%") # 1 out of 3 trips is electric
    end

    it "displays child rider statistics" do
      expect(response.body).to include("Child Riders")
      expect(response.body).to include("33.3%") # 1 out of 3 trips is a child
    end

    it "displays vehicle type section" do
      expect(response.body).to include("Vehicle Types")
    end

    it "displays gender presentation section" do
      expect(response.body).to include("Gender Presentation (by clothing)")
    end

    it "displays age groups section" do
      expect(response.body).to include("Age Groups")
      expect(response.body).to include("Children")
      expect(response.body).to include("Adults")
    end

    it "displays individual trips section" do
      expect(response.body).to include("Individual Trips")
    end

    it "displays action links" do
      expect(response.body).to include("Edit Recording")
      expect(response.body).to include("Back to Home")
    end

    context "when recording has no location data" do
      let(:recording) do
        Recording.create!(
          title: "Minimal Recording",
          date: Date.today,
          time_start: "10:00",
          time_end: "11:00",
          recorder_name: "Jane Smith"
        )
      end

      it "still displays the page successfully" do
        expect(response).to have_http_status(:success)
        expect(response.body).to include("Minimal Recording")
        expect(response.body).to include("Jane Smith")
      end
    end
  end
end