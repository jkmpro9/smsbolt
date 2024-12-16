class SmsMessage {
  final String sender;
  final String content;
  final DateTime timestamp;
  final String? summary;

  const SmsMessage({
    required this.sender,
    required this.content,
    required this.timestamp,
    this.summary,
  });

  @override
  String toString() {
    return '''
From: $sender
Time: $timestamp
Message: $content
${summary != null ? 'Summary: $summary' : ''}
''';
  }
}
