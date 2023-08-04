import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

void main() {
  runApp(MyApp());
}

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

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  final DiscordWebhookSender webhookSender = DiscordWebhookSender(
      'YOUR_DISCORD_WEBHOOK_URL_HERE');

  TextEditingController webhookUrlController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('Discord Webhook Sender By Vexxo'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  child: TextFormField(
                    controller: webhookUrlController,
                    decoration: InputDecoration(
                      hintText: 'Enter Discord webhook URL',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 300,
                  child: TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter your custom message',
                    ),
                    onFieldSubmitted: (_) {
                      _sendWebhookMessage();
                    },
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _sendWebhookMessage();
                  },
                  child: Text('Send Webhook Message'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _showDeveloperInfoPage(context);
                  },
                  child: Text('Developer Info'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _sendWebhookMessage() async {
    String webhookUrl = webhookUrlController.text.trim();
    String content = messageController.text.trim();

    if (webhookUrl.isNotEmpty && content.isNotEmpty) {
      final DiscordWebhookSender webhookSender = DiscordWebhookSender(webhookUrl);
      await webhookSender.sendWebhook(content);
      messageController.clear();
    } else {
      print('Webhook URL and message cannot be empty.');
    }
  }

  void _showDeveloperInfoPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DeveloperInfoPage()),
    );
  }
}

class DeveloperInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF282527),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 122,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 120,
                    backgroundImage: AssetImage('images/image.png'),
                  ),
                ),
                Text(
                  'Vexxo Dev',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'Cairo',
                  ),
                ),
                Divider(
                  color: Color(0xFF6de3e4),
                  thickness: 2,
                  indent: 60,
                  endIndent: 60,
                  height: 20,
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(
                      Icons.mail,
                      size: 32,
                      color: Color(0xFF282527),
                    ),
                    title: Text(
                      'yassintube126@gmail.com',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      size: 32,
                      color: Color(0xFF282527),
                    ),
                    title: Text(
                      '+201207543286',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Navigate back to the previous page (main.dart)
                  },
                  child: Text('Back to Main'),
                ),
                SizedBox(height: 20),
                Link(
                  target: LinkTarget.self,
                  uri: Uri.parse('https://vexxo.code.blog'),
                  builder: (context, followLink) => ElevatedButton(
                    child: Text('Open Our Website'),
                    onPressed: followLink,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
