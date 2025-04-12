<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Voice Assistant - WhistleSafe</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background: #000;
      color: #00ffc8;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      height: 100vh;
      text-align: center;
    }

    .mic-btn {
      background: #00ffc8;
      border: none;
      padding: 15px 25px;
      font-size: 1.2rem;
      border-radius: 10px;
      cursor: pointer;
      box-shadow: 0 0 15px #00ffc8aa;
      transition: 0.3s ease;
    }

    .mic-btn:hover {
      background: #000;
      color: #00ffc8;
      border: 2px solid #00ffc8;
    }

    #output {
      margin-top: 20px;
      font-size: 1.1rem;
      color: white;
    }
  </style>
</head>
<body>

  <h1>🕊️ WhistleSafe Voice Assistant</h1>
  <button class="mic-btn" onclick="startAssistant()">🎤 Activate Assistant</button>
  <div id="output"></div>

  <script>
    const output = document.getElementById('output');

    // Speech synthesis (Assistant speaks)
    function speak(text) {
      const synth = window.speechSynthesis;
      const utter = new SpeechSynthesisUtterance(text);
      utter.lang = 'en-US';
      synth.speak(utter);
    }

    // Assistant greeting
    speak("Hello! I'm your voice assistant. Say 'file a report', 'check status', or 'contact support'.");

    // Voice recognition logic
    function startAssistant() {
      if (!('webkitSpeechRecognition' in window)) {
        output.innerText = "Voice recognition is not supported in this browser.";
        return;
      }

      const recognition = new webkitSpeechRecognition();
      recognition.lang = 'en-US';
      recognition.interimResults = false;
      recognition.continuous = false;

      recognition.start();
      speak("Listening...");

      recognition.onresult = function(event) {
        const transcript = event.results[0][0].transcript.toLowerCase();
        output.innerText = "You said: " + transcript;

        if (transcript.includes('file')) {
          speak("Redirecting you to the report page.");
          window.location.href = 'report.html';
        } else if (transcript.includes('status')) {
          speak("Taking you to the case status tracker.");
          window.location.href = 'status.html';
        } else if (transcript.includes('contact')) {
          speak("Opening the contact support page.");
          window.location.href = 'contact.html';
        } else {
          speak("Sorry, I didn't catch that. Please try again.");
        }
      };

      recognition.onerror = function(event) {
        speak("Microphone access denied or not supported. Please allow mic or try HTTPS.");
        output.innerText = "Error: " + event.error;
      };
    }
  </script>

</body>
</html>
