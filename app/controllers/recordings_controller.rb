class RecordingsController < ApplicationController
  before_action :set_recording, only: [:show, :edit, :update]

  def show
    @trips = @recording.trips.includes(image_attachment: :blob)
    
    # Aggregate data for charts
    @helmet_data = @trips.group(:wearing_helmet).count
    @gender_data = @trips.group(:gender_of_clothing).count
    @vehicle_data = @trips.group(:vehicle).count
    @electric_data = @trips.group(:electric).count
    @child_data = @trips.group(:child).count
    
    # Calculate percentages
    total_trips = @trips.count
    @helmet_percentage = calculate_percentage(@helmet_data[true], total_trips)
    @child_percentage = calculate_percentage(@child_data[true], total_trips)
    @electric_percentage = calculate_percentage(@electric_data[true], total_trips)
  end

  def new
    @recording = Recording.new
  end

  def edit
  end

  def create
    @recording = Recording.new(recording_params)
    
    if @recording.save
      redirect_to @recording, notice: 'Recording was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    # Handle cover image removal
    if params[:recording][:remove_cover_image] == '1'
      @recording.cover_image.purge
    end
    
    if @recording.update(recording_params)
      # Handle image uploads and create trips
      if params[:recording][:images].present?
        create_trips_from_images(params[:recording][:images])
      end
      
      redirect_to edit_recording_path(@recording), notice: 'Recording was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_recording
    @recording = Recording.find(params[:id])
  end
  
  def calculate_percentage(count, total)
    return 0 if total == 0
    ((count.to_f / total) * 100).round(1)
  end

  def recording_params
    params.require(:recording).permit(:date, :time_start, :time_end, :gps_coordinates, :address, :city, :state, :title, :recorder_name, :cover_image, :remove_cover_image)
  end

  def create_trips_from_images(images)
    images.each do |image|
      next if image.blank?
      
      trip = @recording.trips.build
      trip.image.attach(image)
      trip.save!
      
      # Analyze the image immediately after saving
      trip.analyze_image
    end
  end
end
