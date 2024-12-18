import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sample_project/speech_to_point/speech_point_highlighted_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToPoint extends StatefulWidget {
  const SpeechToPoint({super.key});

  @override
  SpeechToPointState createState() => SpeechToPointState();
}

class SpeechToPointState extends State<SpeechToPoint> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String speek = '';
  bool newLine = false;
  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  List<String> medicines = ['Paracetamol'];

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  Timer? _pauseTimer;
  bool isvalid = false;

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      onSoundLevelChange: (level) {
        // Print the current sound level
        debugPrint("Current sound level: $level");
        // If the sound level drops below a certain threshold (e.g., 0.1), consider it a pause
        if (level < 0.1 && !isvalid) {
          isvalid = true; // Prevent multiple triggers from a single pause

          // Add a new line after detecting silence (pause)
          _pauseTimer?.cancel(); // Cancel any previous pause timer
          _pauseTimer = Timer(const Duration(seconds: 1), () {
            log('passed new line');
            newLine = true;
            isvalid = false; // Allow for new pauses to be detected
            if (mounted) {
              setState(() {});
            }
            // newLine = false;
          });
          // newLine = false;
        }
      },
    );
    setState(() {});
  }

  /// Each time to start a speech recognition session
  // void _startListening() async {
  //   log('Got it');
  //   await _speechToText.listen(
  //     onResult: _onSpeechResult,
  //     onSoundLevelChange: (level) {
  //       // Reset the pause timer if the user speaks again
  //       if (level < 0.1) {
  //         log('trigg');
  //         speek = '$speek loooo';
  //       }

  //       // Start the pause timer if the sound level is low
  //     },
  //   );
  //   setState(() {});
  // }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      speek = result.recognizedWords;
    });
  }

  bool istrue = false;
  @override
  Widget build(BuildContext context) {
    log(speek);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Speech To Point'),
        actions: [
          IconButton(
              onPressed: () {
                _stopListening();
                speek = '';
                istrue = false;
                setState(() {});
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                  padding: const EdgeInsets.all(16),
                  child: SpeechPointHighlightedText(
                      text: _speechToText.isListening
                          ? speek
                          : _speechEnabled
                              ? 'Tap the microphone to start listening...'
                              : 'Speech not available',
                      wordsToHighlight: medicines)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          if (istrue) {
            _stopListening();
            istrue = false;
          } else {
            _startListening();
            istrue = true;
          }
        },
        tooltip: 'Listen',
        child: Icon(
          _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
          color: Colors.white,
        ),
      ),
    );
  }
}
