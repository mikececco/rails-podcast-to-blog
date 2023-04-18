// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"

//= require audio_recordings

// JavaScript
var chunks = [];
var mediaRecorder;
var startBtn = document.getElementById('startBtn');
var stopBtn = document.getElementById('stopBtn');
console.log(startBtn);


startBtn.addEventListener('click', function() {
  console.log("hi");
  navigator.mediaDevices.getUserMedia({ audio: true })
    .then(function(stream) {
      mediaRecorder = new MediaRecorder(stream);
      mediaRecorder.start();
      chunks = [];
      console.log('Recording started.');
    })
    .catch(function(error) {
      console.error('Error accessing microphone:', error);
    });
});

stopBtn.addEventListener('click', function() {
  if (mediaRecorder.state === 'recording') {
    mediaRecorder.stop();
    console.log('Recording stopped.');
  }
});

mediaRecorder.addEventListener('dataavailable', function(event) {
  console.log("Dataaa");
  if (event.data.size > 0) {
    chunks.push(event.data);
  }
});

mediaRecorder.addEventListener('stop', function() {
    console.log("FINITTT");

  var blob = new Blob(chunks, { type: 'audio/webm' });
  var formData = new FormData();
  formData.append('audio', blob, 'recording.webm');

  // Send formData to server for processing
  // using AJAX or other means
});
