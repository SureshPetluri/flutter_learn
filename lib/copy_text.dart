import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Copy Text Example'),
        ),
        body: CopyTextWidget(),
      ),
    );
  }
}

class CopyTextWidget extends StatelessWidget {
  final String textToCopy = 'Hello, Flutter!';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _copyToClipboard(textToCopy);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Text copied to clipboard'),
                ),
              );
            },
            child: Text(
              textToCopy,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}
