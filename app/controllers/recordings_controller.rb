class RecordingsController < ApplicationController
  before_action :set_recording, only: [:show, :edit, :update]

  def show
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
    if @recording.update(recording_params)
      # Handle image uploads and create trips
      if params[:recording][:images].present?
        create_trips_from_images(params[:recording][:images])
      end
      
      redirect_to @recording, notice: 'Recording was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_recording
    @recording = Recording.find(params[:id])
  end

  def recording_params
    params.require(:recording).permit(:date, :time_start, :time_end, :gps_coordinates, :address, :city, :state, :title, :recorder_name)
  end

  def create_trips_from_images(images)
    images.each do |image|
      next if image.blank?
      
      trip = @recording.trips.build
      trip.image.attach(image)
      trip.save!
    end
  end
end
