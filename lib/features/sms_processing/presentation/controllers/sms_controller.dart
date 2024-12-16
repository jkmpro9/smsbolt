import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/config/app_config.dart';
import '../../domain/repositories/sms_repository.dart';
import '../../../../features/discord_integration/domain/repositories/discord_repository.dart';
import '../../../../core/providers/providers.dart';

final smsControllerProvider = StateNotifierProvider<SmsController, AsyncValue<Map<String, dynamic>>>((ref) {
  return SmsController(
    smsRepository: ref.watch(smsRepositoryProvider),
    discordRepository: ref.watch(discordRepositoryProvider),
  );
});

class SmsController extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  final SmsRepository _smsRepository;
  final DiscordRepository _discordRepository;

  SmsController({
    required SmsRepository smsRepository,
    required DiscordRepository discordRepository,
  })  : _smsRepository = smsRepository,
        _discordRepository = discordRepository,
        super(const AsyncValue.data({}));

  Future<void> processSms(String smsContent) async {
    state = const AsyncValue.loading();

    try {
      // Process SMS content
      final processedData = await _smsRepository.processSmsContent(smsContent);
      
      // Send to Discord
      await _discordRepository.sendMessage(
        AppConfig.discordWebhookUrl,
        processedData['discordMessage'],
      );
      
      state = AsyncValue.data(processedData);
    } catch (e, stackTrace) {
      final errorMessage = '❌ Error processing SMS: $e';
      await _discordRepository.sendMessage(
        AppConfig.discordWebhookUrl,
        errorMessage,
      );
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
