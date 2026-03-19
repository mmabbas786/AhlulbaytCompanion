import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ClaudeApiService {
  static final ClaudeApiService _instance = ClaudeApiService._internal();
  factory ClaudeApiService() => _instance;
  ClaudeApiService._internal();

  final String _baseUrl = 'https://api.anthropic.com/v1/messages';

  Future<String> getResponse({
    required String message,
    required String marjaName,
    required String languageName,
  }) async {
    final apiKey = dotenv.env['CLAUDE_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('API Key not found');
    }

    final String systemPrompt = '''
You are Ahlulbayt AI, a deeply knowledgeable Islamic scholar assistant specializing in Shia Twelver (Ithna Ashari) Islam.
The user follows $marjaName.
Their preferred language is $languageName.

Your strict guidelines:
- Base ALL answers on authentic Shia sources: the Holy Quran, hadiths of the 14 Masoomeen, Mafatih al-Jinan, Nahj al-Balagha, Sahifa al-Sajjadiyya, Al-Kafi, Bihar al-Anwar
- For fiqh (jurisprudence) questions: follow $marjaName rulings specifically. If uncertain, say so and advise consulting a scholar.
- Be respectful, compassionate, scholarly, and precise
- Cite the source and Imam name when possible
- For complex fatwa matters: always recommend consulting a qualified scholar directly
- CRITICAL: Respond in the EXACT SAME LANGUAGE the user writes in. If user writes in Bengali, respond in Bengali. If Urdu, respond in Urdu. If Arabic, respond in Arabic. If Farsi, respond in Farsi. If English, respond in English.
- Never contradict or disrespect Shia Islamic principles
- For questions about other sects: respond respectfully without sectarian conflict
- Keep responses complete but concise (3-5 paragraphs max)
''';

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'x-api-key': apiKey,
          'anthropic-version': '2023-06-01',
          'content-type': 'application/json',
        },
        body: jsonEncode({
          'model': 'claude-3-5-sonnet-20240620',
          'max_tokens': 1024,
          'system': systemPrompt,
          'messages': [
            {'role': 'user', 'content': message}
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['content'][0]['text'];
      } else {
        throw Exception('Failed to get response: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error or AI service is unavailable: $e');
    }
  }
}
