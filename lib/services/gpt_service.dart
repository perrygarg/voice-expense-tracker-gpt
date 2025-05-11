import 'dart:convert';
import 'package:http/http.dart' as http;

class GPTService {
  static const String _apiKey = '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';
  static const String _url = 'https://api.openai.com/v1/chat/completions';

  Future<Map<String, dynamic>> parseExpense(String sentence) async {
    final prompt = '''
Extract the following fields from the input text:
- amount (with currency symbol if available)
- merchant
- date
- paymentType
- category (based on context like Zomato → Dining, Amazon → Shopping)

Return only valid JSON (no markdown, no explanation).

Input: "$sentence"
''';

    final response = await http.post(
      Uri.parse(_url),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "system", "content": "You are a financial transaction parser."},
          {"role": "user", "content": prompt}
        ],
        "temperature": 0.2,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final message = data['choices'][0]['message']['content'];
      return jsonDecode(message);
    } else {
      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");
      throw Exception('Failed to fetch GPT response');
    }
  }
}