abstract class SmsRepository {
  Future<Map<String, dynamic>> processSmsContent(String smsContent);
}
