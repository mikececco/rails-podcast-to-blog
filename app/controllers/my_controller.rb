class MyController < ApplicationController
  def translate_file
    # Create a new OpenAI client object
    client = OpenAI::Client.new(access_token: ENV['OPENAI_ACCESS_TOKEN'])

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

      if response['error']
        @transcription = response['error']['message']
      else
        @transcription = response['text']
      end
    rescue OpenAI::Error => e
      puts "An error occurred: #{e.message}"
    end

  end
end
