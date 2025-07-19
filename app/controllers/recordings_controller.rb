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
end
