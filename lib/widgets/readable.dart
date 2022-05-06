import 'package:flutter/material.dart';
import 'package:text_to_speech/text_to_speech.dart';

TextToSpeech tts = TextToSpeech();

Future speak(String text,
    {int volume = 1, double rate = 1.0, double pitch = 1.0}) async {
  /// Use the text_to_speech library to read text to a user
  await tts.speak(text);
}

class Readable extends StatelessWidget {
  /// Wrap any widget with this to give it the following properties:
  /// 1. Upon release of a long press an arbitrary message will be read out loud
  /// to the user
  /// 2. TODO This object will flash for a secon when it begins reading its message

  const Readable({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(text),
      onLongPress: () async {
        await speak(text);
      },
    );
  }
}
