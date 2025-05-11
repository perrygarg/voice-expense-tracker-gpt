import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final SpeechToText _speech = SpeechToText();

  Future<bool> init() async {
    return await _speech.initialize();
  }

  Future<void> startListening(Function(String) onResult) async {
    await _speech.listen(
      onResult: (result) => onResult(result.recognizedWords),
      localeId: 'en_IN',
    );
  }

  void stopListening() {
    _speech.stop();
  }
}