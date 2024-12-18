import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sample_project/speech_to_note/speech_note_highlighted_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToNote extends StatefulWidget {
  const SpeechToNote({super.key});

  @override
  SpeechToNoteState createState() => SpeechToNoteState();
}

class SpeechToNoteState extends State<SpeechToNote> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String speek = '';

  @override
  void dispose() {
    istrue = false;
    _speechToText.stop();
    super.dispose();
  }

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

  // Each time to start a speech recognition session
  void _startListening() async {
    log('Got it');
    await _speechToText.listen(
      onResult: _onSpeechResult,
      onSoundLevelChange: (level) {
        // Start the pause timer if the sound level is low
      },
    );
    setState(() {});
  }

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
        title: const Text('Speech To Note'),
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
                  child: SpeechNoteHighlightedText(
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
