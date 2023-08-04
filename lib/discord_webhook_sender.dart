import 'dart:convert';
import 'package:http/http.dart' as http;

class DiscordWebhookSender {
  final String webhookUrl;

  DiscordWebhookSender(this.webhookUrl);

  Future<void> sendWebhook(String content) async {
    try {
      final Map<String, dynamic> data = {'content': content};
      final String jsonData = jsonEncode(data);

      final response = await http.post(
        Uri.parse(webhookUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      if (response.statusCode == 204) {
        print('Webhook sent successfully');
      } else {
        print('Failed to send webhook - ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending webhook: $e');
    }
  }
}
