import 'package:flutter/material.dart';

const imageUrl =
    'https://images.unsplash.com/photo-1622393168445-ed318ea0554f?w=1024&q=80';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(home: MasterPage());
}

class MasterPage extends StatelessWidget {
  const MasterPage({super.key});

  @override
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
          MaterialPageRoute(builder: (context) => const DetailPage()),
        ),
      ),
    ),
  );
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
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