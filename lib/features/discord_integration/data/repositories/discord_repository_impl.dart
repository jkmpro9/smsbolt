import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/repositories/discord_repository.dart';

class DiscordRepositoryImpl implements DiscordRepository {
  final http.Client _client;

  DiscordRepositoryImpl({
    required http.Client client,
  }) : _client = client;

  @override
  Future<bool> sendMessage(String webhookUrl, String message) async {
    try {
      final response = await _client.post(
        Uri.parse(webhookUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'content': message}),
      );

      if (response.statusCode == 204) {
        return true;
      }

      throw Exception(
        'Failed to send message to Discord. Status code: ${response.statusCode}',
      );
    } catch (e) {
      throw Exception('Error sending message to Discord: $e');
    }
  }
}
