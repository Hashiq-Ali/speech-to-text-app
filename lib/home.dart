import 'package:flutter/material.dart';
import 'package:sample_project/speech_to_note/speech_to_note.dart';
import 'package:sample_project/speech_to_point/speech_to_point.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const SpeechToPoint()));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.tealAccent,
                    borderRadius: BorderRadius.circular(20)),
                child: const Center(
                  child: Text(
                    'Speech To Point',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )),
          const SizedBox(height: 5),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const SpeechToNote()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                        child: Text(
                          'Speech To Note',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ))),
          const Expanded(flex: 4, child: SizedBox()),
        ],
      ),
    );
  }
}
