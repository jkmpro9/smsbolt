import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import '../../features/discord_integration/data/repositories/discord_repository_impl.dart';
import '../../features/discord_integration/domain/repositories/discord_repository.dart';
import '../../features/gemini_integration/data/repositories/gemini_repository_impl.dart';
import '../../features/gemini_integration/domain/repositories/gemini_repository.dart';
import '../../features/sms_processing/data/repositories/sms_repository_impl.dart';
import '../../features/sms_processing/domain/repositories/sms_repository.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Core
  getIt.registerLazySingleton<http.Client>(() => http.Client());

  // Repositories
  getIt.registerLazySingleton<DiscordRepository>(
    () => DiscordRepositoryImpl(client: getIt<http.Client>()),
  );

  getIt.registerLazySingleton<GeminiRepository>(
    () => GeminiRepositoryImpl(apiKey: AppConfig.geminiApiKey),
  );

  getIt.registerLazySingleton<SmsRepository>(
    () => SmsRepositoryImpl(
      client: getIt<http.Client>(),
      discordRepository: getIt<DiscordRepository>(),
      geminiRepository: getIt<GeminiRepository>(),
    ),
  );
}
