require 'rest-client'

class MyController < ApplicationController
  def translate_file
    # Create a new OpenAI client object
    client = OpenAI::Client.new

    # Open the audio file using File.open
    audio_path = Rails.root.join("app", "assets", "public", "audio", "song.mp3")

    # Call the transcription method and pass the audio file
    begin
      response = client.transcribe(
        parameters: {
          model: "whisper-1",
          file: File.open(audio_path, "rb")
        }
      )
      # handle the response here
      @transcription = response.parsed_response['text']
    rescue RestClient::Exception => e
      puts "An error occurred: #{e.message}"
    end

  end
end
