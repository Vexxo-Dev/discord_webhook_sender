import 'package:flutter/material.dart';

import 'package:url_launcher/link.dart';


void main() {
  runApp(DeveloperInfoPage()
  );
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
                    Navigator.pop(
                        context); // Navigate back to the previous page (main.dart)
                  },
                  child: Text('Back to Main'),
                ),
                SizedBox(height: 20),
                Link(target: LinkTarget.self,
                uri: Uri.parse('https://vexxo.code.blog'),
                 builder: (context, followLink) => ElevatedButton(
                  child: Text('Open Our Website'),
                   onPressed: followLink,),), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}
