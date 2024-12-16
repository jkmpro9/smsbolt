import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smsbolt/core/di/dependency_injection.dart';
import 'package:smsbolt/features/sms_processing/domain/repositories/sms_repository.dart';

final smsRepositoryProvider = Provider<SmsRepository>((ref) {
  return getIt<SmsRepository>();
});
