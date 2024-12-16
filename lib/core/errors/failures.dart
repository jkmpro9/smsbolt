abstract class Failure {
  final String message;
  const Failure(this.message);
}

class SmsProcessingFailure extends Failure {
  const SmsProcessingFailure(super.message);
}

class DiscordFailure extends Failure {
  const DiscordFailure(super.message);
}

class GeminiFailure extends Failure {
  const GeminiFailure(super.message);
}
