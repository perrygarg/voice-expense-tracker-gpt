import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../services/SpeechService.dart';
import '../services/gpt_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SpeechService _speechService = SpeechService();
  bool _isSpeechAvailable = false;
  String _transcription = "";


  final GPTService _gptService = GPTService();
  Map<String, dynamic>? _parsedExpense;

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

  void _onSpeechResult(String result) async {
    setState(() {
      _transcription = result;
      _parsedExpense = null; // reset
    });

    try {
      final parsed = await _gptService.parseExpense(result);
      setState(() {
        _parsedExpense = parsed;
      });
      print("Parsed: $parsed");
    } catch (e) {
      print("Error parsing: $e");
    }
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
            if (_parsedExpense != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const Text("Parsed Output", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Amount: ${_parsedExpense!['amount']}"),
                  Text("Merchant: ${_parsedExpense!['merchant']}"),
                  Text("Payment Type: ${_parsedExpense!['paymentType']}"),
                  Text("Category: ${_parsedExpense!['category']}"),
                  Text("Date: ${_parsedExpense!['date']}"),
                ],
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