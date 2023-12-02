
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(FlipHalfContainerApp());
}

class FlipHalfContainerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlipHalfContainerScreen(direction:FlipDirection.up ,),
    );
  }
}
enum FlipDirection { up, down }

class FlipHalfContainerScreen extends StatefulWidget {
  const FlipHalfContainerScreen({super.key, required this.direction});
  final FlipDirection direction;
  @override
  _FlipHalfContainerScreenState createState() => _FlipHalfContainerScreenState();
}

class _FlipHalfContainerScreenState extends State<FlipHalfContainerScreen> {
  double dy = 0;
  double lowerDy = 0;
  bool isFlipped = false;
  final _perspective = 0.003;
  final _zeroAngle = 0.0001;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flip Half Container Demo'),
      ),
      body: Center(
        child: /*Transform(
          transform: Matrix4(
            1, 0, 0, 0,
            0, 1, 0, 0,
            0, 0, 1, 0,
            0, 0, 0, 1,
          )..setEntry(3, 2, 0.001)
            ..rotateX(0.01 * dy),

          alignment: Alignment.center,
          child: Container(
            width: 300,
            height: 500,
            color: Colors.blue,
            child: isFlipped
                ? Align(
              alignment: Alignment.center,
              child: Container(
                width: 200,
                height: 100,
                child: Center(
                  child: Text(
                    'Page 1',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
                color: Colors.blue.withOpacity(0.5),
              ),
            )
                : Align(
              alignment: Alignment.center,
              child: Container(
                width: 200,
                height: 100,
                child: Center(
                  child: Text(
                    'Page 2',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
                color: Colors.blue.withOpacity(0.5),
              ),
            ),
          ),
        ),*/

        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    dy += details.delta.dy;
                    if (dy >= 0) {
                      isFlipped = false;
                    } else {
                      isFlipped = true;
                    }
                  });
                },child: _buildUpperFlipPanel()),
            // Padding(
            //   padding: EdgeInsets.only(top: 10),
            // ),
            GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    lowerDy += details.delta.dy;
                    if (lowerDy >= 0) {
                      isFlipped = false;
                    } else {
                      isFlipped = true;
                    }
                  });
                },child: _buildLowerFlipPanel()),
          ],
        ),
      ),
    );
  }
  Widget _buildUpperFlipPanel() => widget.direction == FlipDirection.up
      ? Stack(
    children: [
      Transform(
        alignment: Alignment.bottomCenter,
        transform: Matrix4.identity()
          ..setEntry(3, 2, _perspective)
          ..rotateX(0.01 * dy),
        child: Container(
          alignment: Alignment.center,
          width: 96.0,
          height: 128.0,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          child: Text(
            '1',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 80.0,
                color: Colors.yellow),
          ),
        ),
      ),
      Transform(
        alignment: Alignment.bottomCenter,
        transform: Matrix4.identity()
          ..setEntry(3, 2, _perspective)
          ..rotateX( 0.01 * dy),
        child: Container(
          alignment: Alignment.center,
          width: 96.0,
          height: 128.0,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          child: Text(
            '1',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 80.0,
                color: Colors.yellow),
          ),
        ),
      ),
    ],
  )
      : Stack(
    children: [
      Transform(
          alignment: Alignment.bottomCenter,
          transform: Matrix4.identity()
            ..setEntry(3, 2, _perspective)
            ..rotateX(0.01 * dy),
          child: Text("1")),
      Transform(
        alignment: Alignment.bottomCenter,
        transform: Matrix4.identity()
          ..setEntry(3, 2, _perspective)
          ..rotateX( math.pi / 2 ),
        child: Text("1"),
      ),
    ],
  );

  Widget _buildLowerFlipPanel() => widget.direction == FlipDirection.up
      ? Stack(
    children: [
      Transform(
        alignment: Alignment.topCenter,
        transform: Matrix4.identity()
          ..setEntry(3, 2, _perspective)
          ..rotateX(_zeroAngle),
        child: Container(
          alignment: Alignment.center,
          width: 96.0,
          height: 128.0,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          child: Text(
            '1',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 80.0,
                color: Colors.yellow),
          ),
        ),),
      Transform(
        alignment: Alignment.topCenter,
        transform: Matrix4.identity()
          ..setEntry(3, 2, _perspective)
          ..rotateX( 0.01 * lowerDy),
        child: Container(
          alignment: Alignment.center,
          width: 96.0,
          height: 128.0,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          child: Text(
            '1',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 80.0,
                color: Colors.yellow),
          ),
        ),
      )
    ],
  )
      : Stack(
    children: [
      Transform(
        alignment: Alignment.topCenter,
        transform: Matrix4.identity()
          ..setEntry(3, 2, _perspective)
          ..rotateX(_zeroAngle),
        child: Container(
          alignment: Alignment.center,
          width: 96.0,
          height: 128.0,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          child: Text(
            '1',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 80.0,
                color: Colors.yellow),
          ),
        ),),
      Transform(
        alignment: Alignment.topCenter,
        transform: Matrix4.identity()
          ..setEntry(3, 2, _perspective)
          ..rotateX(- math.pi / 2),
        child: Container(
          alignment: Alignment.center,
          width: 96.0,
          height: 128.0,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          child: Text(
            '1',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 80.0,
                color: Colors.yellow),
          ),
        ),
      )
    ],
  );
}
