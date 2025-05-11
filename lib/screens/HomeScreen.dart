import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../services/SpeechService.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SpeechService _speechService = SpeechService();
  bool _isSpeechAvailable = false;
  String _transcription = "";

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    await Permission.microphone.request();
    bool available = await _speechService.init();
    print("Speech initialized: $available");
    setState(() {
      _isSpeechAvailable = available;
    });
  }

  void _onSpeechResult(String result) {
    setState(() {
      _transcription = result;
    });
    print("Speech result: $result");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Voice Expense Tracker")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              _transcription.isNotEmpty ? _transcription : "Your voice input will appear here",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            if (!_isSpeechAvailable)
              const Text(
                "Speech service is not available. Please check mic permissions.",
                style: TextStyle(color: Colors.red),
              ),
            ElevatedButton(
              onPressed: _isSpeechAvailable
                  ? () => _speechService.startListening(_onSpeechResult)
                  : null,
              child: const Text("Start Speaking"),
            ),
            ElevatedButton(
              onPressed: _isSpeechAvailable ? _speechService.stopListening : null,
              child: const Text("Stop"),
            ),
          ],
        ),
      ),
    );
  }
}