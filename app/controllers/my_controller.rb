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
        puts "Entering ChatReqqqqqqqqqqqqqqqqqqqq"
        to_extract = response['text']
        message_data = []
        message_data.push({ role: "user", content: "Extract the interesting partsa and group them:#{to_extract}" })
        response = client.chat(
          parameters: {
            model: "gpt-3.5-turbo",
            messages: message_data
          }
        )
        if response['error']
          puts response['error']['message']
        else
          puts response['text']
          puts response
          @transcription = response.dig("choices", 0, "message", "content").gsub(/\n/, '<br/>').html_safe
          puts "Its cominggg"
          end
      end
    rescue OpenAI::Error => e
      puts "An error occurred: #{e.message}"
    end
  end
end
