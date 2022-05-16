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
    required this.child,
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  final Widget child;
  static ValueNotifier<Color> color = ValueNotifier(Colors.transparent);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedBuilder(
        animation: color,
        builder: (_, __) => Container(
          child: child,
          color: Colors.transparent,
        ),
      ),
      onLongPress: () async {
        color.value = Colors.blue;
        speak(text).then((_) => color.value = Colors.transparent);
      },
    );
  }

  /// Create a readable item that has text that is visible to the the user
  factory Readable.text(text) => Readable(child: Text(text), text: text);
}
