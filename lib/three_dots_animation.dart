import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: MyWidget(colors: [Colors.blue, Colors.red, Colors.green]),
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  final List<Color> colors;

  const MyWidget({Key? key, required this.colors}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> with TickerProviderStateMixin {
  int currentPoint = 0;
  Animation<double>? animation;
  AnimationController? controller;
  bool forward = false;
  bool reverse = false;

  @override
  void initState() {
    super.initState();
    currentPoint = 0;
    forward = false;
    reverse = false;
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    animation = CurvedAnimation(
      parent: controller!,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    );

    animation?.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        forward = true;
        print('Forwarded');
      } else if (status == AnimationStatus.reverse) {
        reverse = true;
        print('Reversed');
      }
      if (reverse && forward) {
        currentPoint++;
        forward = false;
        reverse = false;
        print('Reset. Current point: $currentPoint');
      }
    });
    animation?.addListener(() {
      setState(() {});
    });
    controller?.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    var value = animation!.value * (currentPoint.isOdd ? -1 : 1);
    bool isReverse = controller?.status == AnimationStatus.reverse;
    double size = 200;

    return Scaffold(
      body: Center(
        child: SizedBox.fromSize(
          size: Size(size, size),
          child: AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: [
                for (int ind in generateSequence())
                  Positioned.fill(
                    child: Align(
                      alignment: getAlignmentForDistance(
                        isReverse ? -value : value,
                        angles![ind],
                      ),
                      child: Container(
                        height: interpolate(value) ?? 0,
                        width: interpolate(value),
                        decoration: BoxDecoration(
                          color: widget.colors[ind],
                          borderRadius:
                          BorderRadius.circular(interpolate(value)),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double interpolate(double value) {
    var minBound = 12;
    var maxBound = 48;

    return double.parse("${(minBound + (value.abs() * (maxBound - minBound))).clamp(minBound, maxBound)}");
  }

  List<double>? _angles;
  List<double>? get angles {
    _angles ??= List.generate(
      colorCount,
          (index) => 360 / colorCount * (index + 1),
    );
    return _angles;
  }

  double degToRad(double deg) {
    return deg * math.pi / 180;
  }

  Alignment getAlignmentForDistance(double x, double deg) {
    return Alignment(
      x * math.cos(degToRad(deg)),
      x * math.sin(degToRad(deg)),
    );
  }

  int get colorCount => widget.colors.length;

  Iterable<int> generateSequence() sync* {
    for (int i = 0; i < colorCount; i++) {
      yield (currentPoint + i) % colorCount;
    }
  }
}