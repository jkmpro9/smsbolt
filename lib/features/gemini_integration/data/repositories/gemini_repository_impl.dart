import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../domain/repositories/gemini_repository.dart';

class GeminiRepositoryImpl implements GeminiRepository {
  final GenerativeModel _model;

  GeminiRepositoryImpl({required String apiKey})
      : _model = GenerativeModel(
          model: 'gemini-pro',
          apiKey: apiKey,
        );

  @override
  Future<Map<String, dynamic>> processText(String text) async {
    try {
      final prompt = '''
Analyze this SMS and extract the following information in JSON format:
{
  "amount": "amount in the SMS (numeric value only)",
  "balance": "balance in the SMS (numeric value only)",
  "sender": "sender name",
  "phone": "phone number",
  "reference": "transaction reference",
  "operator": "operator name (ORANGE MONEY, MPESA, or AIRTEL MONEY)",
  "type": "ENTRANT if money received, SORTANT if money sent"
}

SMS: $text
''';

      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      
      if (response.text == null || response.text!.isEmpty) {
        throw Exception('Pas de réponse générée par Gemini');
      }

      // Nettoyer la réponse pour extraire uniquement le JSON
      final cleanJson = response.text!.replaceAll(RegExp(r'```json\n|```'), '').trim();
      
      try {
        final Map<String, dynamic> parsedData = json.decode(cleanJson);
        return {
          'amount': parsedData['amount']?.toString() ?? '',
          'balance': parsedData['balance']?.toString() ?? '',
          'sender': parsedData['sender']?.toString() ?? '',
          'phone': parsedData['phone']?.toString() ?? '',
          'reference': parsedData['reference']?.toString() ?? '',
          'operator': (parsedData['operator']?.toString() ?? 'INCONNU').toUpperCase(),
          'type': (parsedData['type']?.toString() ?? 'INCONNU').toUpperCase(),
        };
      } catch (e) {
        print('JSON reçu: $cleanJson');
        print('Erreur de parsing: $e');
        throw FormatException('Erreur de parsing JSON: $cleanJson');
      }
    } catch (e) {
      print('Erreur de traitement: $e');
      throw Exception('Erreur lors du traitement du texte: $e');
    }
  }
}
