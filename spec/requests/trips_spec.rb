require 'rails_helper'

RSpec.describe "Trips", type: :request do
  describe "GET /trips/:id" do
    let(:recording) do
      Recording.create!(
        title: "Morning Commute",
        recorder_name: "John Doe",
        date: Date.today,
        time_start: Time.current.beginning_of_day + 8.hours,
        time_end: Time.current.beginning_of_day + 9.hours,
        address: "123 Main St",
        city: "San Francisco",
        state: "CA",
        gps_coordinates: "37.7749° N, 122.4194° W"
      )
    end

    let(:trip) do
      Trip.create!(
        recording: recording,
        vehicle: "bicycle",
        clothing: "casual",
        gender_of_clothing: "neutral",
        passenger_count: 1,
        wearing_helmet: true,
        electric: false,
        child: false
      )
    end

    before do
      get trip_path(trip)
    end

    it "returns a successful response" do
      expect(response).to have_http_status(:success)
    end

    it "displays the trip details heading" do
      expect(response.body).to include("Trip Details")
    end

    it "displays the vehicle information section" do
      expect(response.body).to include("Vehicle Information")
    end

    it "displays the rider information section" do
      expect(response.body).to include("Rider Information")
    end

    it "displays the vehicle type" do
      expect(response.body).to include("Vehicle Type")
      expect(response.body).to include("Bicycle") # capitalized version of 'bicycle'
    end

    it "displays the helmet status" do
      expect(response.body).to include("Helmet Usage")
      expect(response.body).to include("Wearing helmet")
    end

    it "displays the electric status" do
      expect(response.body).to include("Electric")
      expect(response.body).to include("Non-electric")
    end

    it "displays the passenger count" do
      expect(response.body).to include("Passenger Count")
      expect(response.body).to include("1")
    end

    it "displays the age category" do
      expect(response.body).to include("Age Category")
      expect(response.body).to include("Adult")
    end

    it "displays the clothing type" do
      expect(response.body).to include("Clothing Type")
      expect(response.body).to include("casual")
    end

    it "displays the gender presentation" do
      expect(response.body).to include("Gender Presentation (by clothing)")
      expect(response.body).to include("neutral")
    end

    it "displays the edit trip link" do
      expect(response.body).to include("Edit Trip")
      expect(response.body).to include(edit_trip_path(trip))
    end

    it "displays the back to recording link" do
      expect(response.body).to include("Back to Recording")
      expect(response.body).to include(recording_path(recording))
    end

    context "when the trip has no image" do
      it "displays the no image message" do
        expect(response.body).to include("No image available")
      end
    end

    context "with different trip attributes" do
      let(:trip) do
        Trip.create!(
          recording: recording,
          vehicle: "scooter",
          clothing: "athletic",
          gender_of_clothing: "masculine",
          passenger_count: 2,
          wearing_helmet: false,
          electric: true,
          child: true
        )
      end

      it "displays electric badge" do
        expect(response.body).to include("⚡ Electric")
      end

      it "displays no helmet status" do
        expect(response.body).to include("No helmet")
      end

      it "displays child badge" do
        expect(response.body).to include("Child")
      end

      it "displays updated passenger count" do
        expect(response.body).to include("2")
      end
    end
  end
end