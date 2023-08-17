import 'package:flutter/material.dart';


void main() => runApp( const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) => const MaterialApp(home: AnimationImage());
}


class AnimationImage extends StatefulWidget {
  const AnimationImage({Key? key}) : super(key: key);

  @override
  State<AnimationImage> createState() => _AnimationImageState();
}

class _AnimationImageState extends State<AnimationImage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  String imageUrl =
      'https://images.unsplash.com/photo-1622393168445-ed318ea0554f?w=1024&q=80';

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000,));

    animation = Tween(begin: 0.0, end: 400.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(

      padding: EdgeInsets.all(32.0),
      height: animation.value,
      width: animation.value,
      child: Center(
        child: Image.network(imageUrl,),
      ),
    ));
  }
}
