class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  def show
  end

  def edit
  end

  def update
    if @trip.update(trip_params)
      redirect_to edit_recording_path(@trip.recording), notice: 'Trip was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    recording = @trip.recording
    @trip.destroy
    redirect_to edit_recording_path(recording), notice: 'Trip was successfully deleted.'
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:vehicle, :clothing, :gender_of_clothing, :passenger_count, :wearing_helmet, :electric, :child)
  end
end