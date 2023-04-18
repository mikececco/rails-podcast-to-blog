class RecordingsController < ApplicationController
  def create
    raise
    audio = params[:audio]
    recording = Recording.new
    recording.audio.attach(audio)
    # Perform audio processing on the recording if needed
    if recording.save
      render json: { message: 'Recording uploaded successfully' }
    else
      render json: { error: 'Failed to upload recording' }
    end
  end
end
