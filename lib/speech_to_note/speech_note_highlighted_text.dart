import 'package:flutter/material.dart';
import 'package:sample_project/localization/number_words.dart';

class SpeechNoteHighlightedText extends StatelessWidget {
  final String text; // Full input text
  final List<String> wordsToHighlight; // List of words to highlight
  final TextStyle normalStyle; // Default style
  final TextStyle highlightStyle; // Highlighted style

  const SpeechNoteHighlightedText({
    super.key,
    required this.text,
    required this.wordsToHighlight,
    this.normalStyle = const TextStyle(fontSize: 16, color: Colors.black),
    this.highlightStyle = const TextStyle(
      fontSize: 16,
      color: Colors.red,
      fontWeight: FontWeight.bold,
    ),
  });

  @override
  Widget build(BuildContext context) {
    // Use a RegExp to match words and spaces without removing spaces
    final wordRegex = RegExp(r'(\w+|[^\w\s]+|\s+)'); // Matches words and spaces
    final matches = wordRegex.allMatches(text);

    return RichText(
      text: TextSpan(
        children: matches.map((match) {
          final word = match.group(0)!; // Extract the matched word or space
          final cleanedWord =
              word.replaceAll(RegExp(r'[^\w]'), ''); // Remove punctuation

          // Check if the word needs to be replaced as a number
          final isNumberWord =
              numberWords.containsKey(cleanedWord.toLowerCase());
          final replacementText =
              isNumberWord ? numberWords[cleanedWord.toLowerCase()]! : word;

          // Check if the cleaned/replaced word is in the highlight list
          final shouldHighlight = wordsToHighlight.any(
            (highlightWord) =>
                replacementText.toLowerCase() == highlightWord.toLowerCase(),
          );

          return TextSpan(
            text: shouldHighlight
                ? replacementText.toUpperCase()
                : replacementText, // Replace text if it's a number word
            style: shouldHighlight ? highlightStyle : normalStyle,
          );
        }).toList(),
      ),
    );
  }
}
