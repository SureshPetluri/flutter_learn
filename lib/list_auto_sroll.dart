import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();
  final double itemWidth = 200.0; // Adjust the item width based on your design

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(Duration(seconds: 2), () {
      if (_scrollController.position.pixels + itemWidth >=
          _scrollController.position.maxScrollExtent) {
        // If at the end, scroll to the beginning
        _scrollController.jumpTo(0.0);
      } else {
        // Otherwise, scroll to the next item
        _scrollController.animateTo(
          _scrollController.position.pixels + itemWidth,
          duration: Duration(seconds: 1),
          curve: Curves.ease,
        );
      }
      _startAutoScroll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auto-scrolling ListView'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        itemCount: 10, // Double the itemCount for loop effect
        itemBuilder: (context, index) {
          // Replace the Container with your custom widget for each item
          return Container(
            height: itemWidth,
            color: Colors.blue,
            margin: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Item $index',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
