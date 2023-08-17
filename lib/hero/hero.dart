import 'package:flutter/material.dart';

const imageUrl =
    'https://images.unsplash.com/photo-1622393168445-ed318ea0554f?w=1024&q=80';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) => MaterialApp(home: MasterPage());
}

class MasterPage extends StatelessWidget {
  Widget build(BuildContext context) => Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        child: Hero(
          tag: 'hero',
          child: Image.network(
            imageUrl,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage()),
        ),
      ),
    ),
  );
}

class DetailPage extends StatelessWidget {
  Widget build(BuildContext context) => Scaffold(
    body: Stack(
      children: [
        Center(
          child: Hero(
            tag: 'hero',
            child: Image.network(imageUrl),
          ),
        ),
        const BackButton(),
      ],
    ),
  );
}