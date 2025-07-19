require "test_helper"

class RecordingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recording = recordings(:one)
  end

  test "should get new" do
    get recordings_new_url
    assert_response :success
  end

  test "should get create" do
    get recordings_create_url
    assert_response :success
  end

  test "should show recording" do
    # Update the recording fixture with realistic data
    @recording.update!(
      title: "Downtown Bike Survey",
      date: Date.new(2025, 7, 19),
      time_start: Time.new(2025, 7, 19, 9, 0, 0),
      time_end: Time.new(2025, 7, 19, 11, 0, 0),
      recorder_name: "Jane Smith",
      address: "123 Main Street",
      city: "Portland",
      state: "Oregon",
      gps_coordinates: "45.5152° N, 122.6784° W"
    )

    # Create trips with various attributes for testing statistics
    # Trip 1: Adult on bicycle with helmet
    @recording.trips.create!(
      vehicle: "bicycle",
      clothing: "casual",
      gender_of_clothing: "masculine",
      passenger_count: 1,
      wearing_helmet: true,
      electric: false,
      child: false
    )

    # Trip 2: Adult on e-bike without helmet
    @recording.trips.create!(
      vehicle: "e-bike",
      clothing: "business",
      gender_of_clothing: "feminine",
      passenger_count: 1,
      wearing_helmet: false,
      electric: true,
      child: false
    )

    # Trip 3: Child on scooter with helmet
    @recording.trips.create!(
      vehicle: "scooter",
      clothing: "athletic",
      gender_of_clothing: "neutral",
      passenger_count: 1,
      wearing_helmet: true,
      electric: false,
      child: true
    )

    # Trip 4: Adult on e-scooter without helmet
    @recording.trips.create!(
      vehicle: "e-scooter",
      clothing: "casual",
      gender_of_clothing: "masculine",
      passenger_count: 1,
      wearing_helmet: false,
      electric: true,
      child: false
    )

    get recording_url(@recording)
    assert_response :success

    # Check for recording title
    assert_select "h1", text: "Downtown Bike Survey"

    # Check for recording details section
    assert_select "p", text: "Recording Details"

    # Check for date field
    assert_select "label", text: "Date"
    assert_select "p", text: @recording.date.to_s

    # Check for recorder name
    assert_select "label", text: "Recorded By"
    assert_select "p", text: "Jane Smith"

    # Check for location details
    assert_select "h3", text: "Location Details"
    assert_select "label", text: "GPS Coordinates"
    assert_select "p", text: "45.5152° N, 122.6784° W"

    # Check for address information
    assert_select "label", text: "Address"
    assert_select "p", text: "123 Main Street"
    assert_select "label", text: "City"
    assert_select "p", text: "Portland"
    assert_select "label", text: "State"
    assert_select "p", text: "Oregon"

    # Check for trip statistics section
    assert_select "h2", text: "Trip Statistics"

    # Check for statistics cards
    assert_select ".grid" do
      # Total Trips card
      assert_select "h3", text: "Total Trips"
      assert_text "4" # Total number of trips

      # Helmet Usage card
      assert_select "h3", text: "Helmet Usage"
      assert_text "50%" # 2 out of 4 wearing helmets
      assert_text "2 of 4 riders"

      # Electric Vehicles card
      assert_select "h3", text: "Electric Vehicles"
      assert_text "50%" # 2 out of 4 electric
      assert_text "2 electric rides"

      # Child Riders card
      assert_select "h3", text: "Child Riders"
      assert_text "25%" # 1 out of 4 is a child
      assert_text "1 children"
    end

    # Check for individual trips section
    assert_select "h2", text: "Individual Trips"

    # Check for action buttons
    assert_select "a", text: "Edit Recording"
    assert_select "a", text: "Back to Home"

    # Check for chart sections
    assert_select "h3", text: "Vehicle Types"
    assert_select "h3", text: "Gender Presentation (by clothing)"
    assert_select "h3", text: "Age Groups"

    # Verify age group statistics
    assert_text "Children"
    assert_text "1 riders"
    assert_text "25%"
    assert_text "Adults"
    assert_text "3 riders"
    assert_text "75%"
  end

  test "should show recording without cover image" do
    @recording.update!(
      title: "Test Recording Without Image",
      recorder_name: "Test User"
    )

    get recording_url(@recording)
    assert_response :success

    # Should show standard header without image
    assert_select "h1", text: "Test Recording Without Image"
    assert_select ".pt-12", count: 1 # Standard header div
  end

  test "should handle recording with no trips" do
    @recording.update!(
      title: "Empty Recording",
      recorder_name: "Test User"
    )
    @recording.trips.destroy_all

    get recording_url(@recording)
    assert_response :success

    # Should still show the page structure
    assert_select "h1", text: "Empty Recording"
    assert_select "h2", text: "Trip Statistics"
    
    # Total trips should be 0
    assert_text "0" # Total trips count
    
    # All percentages should be 0%
    assert_text "0%" # Multiple 0% values for helmet, electric, child percentages
  end
end
