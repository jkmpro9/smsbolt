import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:convert';

class SmsParserService {
  final GenerativeModel model;

  SmsParserService({required this.model});

  Future<Map<String, dynamic>> parseSms(String smsContent) async {
    try {
      final prompt = '''
      Analyze this SMS message and extract the following information in JSON format:
      - type (SEND or RECEIVE)
      - amount
      - balance
      - name (recipient or sender)
      - phone
      - reference
      - operator (M-PESA, ORANGE MONEY, or AIRTEL MONEY)
      - currency (USD)

      SMS: $smsContent
      ''';

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      final responseText = response.text;

      // Extraire le JSON de la réponse
      final jsonStart = responseText?.indexOf('{');
      final jsonEnd = responseText?.lastIndexOf('}');
      final jsonStr = responseText?.substring(jsonStart!, jsonEnd! + 1);
      final Map<String, dynamic> parsedData = json.decode(jsonStr!);

      // Formater le message pour Discord
      final formattedMessage =
          '''⏰ Date: ${DateTime.now().toString().split('.')[0]}

💰 Transaction ${parsedData['type'] == 'RECEIVE' ? '⬇️' : '⬆️'}

💵 Montant: ${parsedData['amount']} ${parsedData['currency']}
💳 Solde: ${parsedData['balance']} ${parsedData['currency']}
👤 ${parsedData['type'] == 'RECEIVE' ? 'De' : 'À'}: ${parsedData['name']}
📱 Téléphone: ${_formatPhone(parsedData['phone'])}
🔖 Référence: ${parsedData['reference']}
🏢 Opérateur: ${_getOperatorEmoji(parsedData['operator'])} ${parsedData['operator']}

🤖 Traité par CoBolt''';

      return {
        'amount': parsedData['amount'],
        'balance': parsedData['balance'],
        'name': parsedData['name'],
        'phone': parsedData['phone'],
        'reference': parsedData['reference'],
        'operator': parsedData['operator'],
        'type': parsedData['type'],
        'currency': parsedData['currency'],
        'formatted_message': formattedMessage,
      };
    } catch (e) {
      throw Exception('Erreur lors du parsing du SMS: $e');
    }
  }

  String _getOperatorEmoji(String operator) {
    switch (operator.toUpperCase()) {
      case 'M-PESA':
        return '🟢';
      case 'ORANGE MONEY':
      case 'ORANGE':
        return '🟠';
      case 'AIRTEL MONEY':
      case 'AIRTEL':
        return '🔴';
      default:
        return '🏢';
    }
  }

  String _formatPhone(String phone) {
    // Formater le numéro de téléphone si nécessaire
    return phone.replaceAll(RegExp(r'[^\d+]'), '');
  }
}
