import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/sms_processing/domain/repositories/sms_repository.dart';
import '../../features/discord_integration/domain/repositories/discord_repository.dart';
import '../../features/gemini_integration/domain/repositories/gemini_repository.dart';
import '../di/dependency_injection.dart';

final smsRepositoryProvider = Provider<SmsRepository>(
  (ref) => getIt<SmsRepository>(),
);

final discordRepositoryProvider = Provider<DiscordRepository>(
  (ref) => getIt<DiscordRepository>(),
);

final geminiRepositoryProvider = Provider<GeminiRepository>(
  (ref) => getIt<GeminiRepository>(),
);
