abstract class DiscordRepository {
  Future<bool> sendMessage(String webhookUrl, String message);
}
