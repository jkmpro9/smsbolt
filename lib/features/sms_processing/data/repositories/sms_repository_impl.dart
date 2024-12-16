import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/constants/operator_constants.dart';
import '../../../discord_integration/domain/repositories/discord_repository.dart';
import '../../../gemini_integration/domain/repositories/gemini_repository.dart';
import '../../domain/repositories/sms_repository.dart';

class SmsRepositoryImpl implements SmsRepository {
  final DiscordRepository _discordRepository;
  final GeminiRepository _geminiRepository;

  SmsRepositoryImpl({
    required http.Client client,
    required DiscordRepository discordRepository,
    required GeminiRepository geminiRepository,
  })  : _discordRepository = discordRepository,
        _geminiRepository = geminiRepository;

  @override
  Future<Map<String, dynamic>> processSmsContent(String smsContent) async {
    try {
      final processedData = await _geminiRepository.processText(smsContent);
      final formattedData = _formatData(processedData);
      
      // Envoie le message formaté à Discord
      await _discordRepository.sendMessage(
        AppConfig.discordWebhookUrl,
        _formatDiscordMessage(formattedData, formattedData['date']),
      );

      return formattedData;
    } catch (e) {
      throw Exception('Erreur lors du traitement du SMS: $e');
    }
  }

  Map<String, dynamic> _formatData(Map<String, dynamic> data) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    final now = DateTime.now();

    return {
      'date': dateFormat.format(now),
      'amount': data['amount'],
      'balance': data['balance'],
      'sender': data['sender'],
      'phone': data['phone'],
      'reference': data['reference'],
      'operator': data['operator'],
    };
  }

  String _formatDiscordMessage(Map<String, dynamic> data, String formattedDate) {
    final operator = (data['operator'] ?? 'INCONNU').toString().toUpperCase();
    final formattedOperator = OperatorConstants.formatOperatorForDiscord(operator);
    final type = (data['type'] ?? 'INCONNU').toString().toUpperCase();
    final typeIcon = type == 'ENTRANT' ? '⬇️' : '⬆️';

    return '''🔔 **PAIEMENT ${type == 'ENTRANT' ? 'REÇU' : 'ENVOYÉ'}** $typeIcon

⏰ **DATE:** ${formattedDate.toUpperCase()}

💰 **TRANSACTION** $typeIcon

💵 **MONTANT:** ${data['amount'].toString().toUpperCase()} USD
💳 **SOLDE:** ${data['balance'].toString().toUpperCase()} USD
👤 **DE:** ${data['sender'].toString().toUpperCase()}
📱 **TELEPHONE:** ${data['phone'].toString().toUpperCase()}
🔖 **REFERENCE:** ${data['reference'].toString().toUpperCase()}
🏢 **OPERATEUR:** ${formattedOperator.toUpperCase()}

🤖 **TRAITE PAR COBOLT** 🚀''';
  }
}
