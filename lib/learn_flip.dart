import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Way2Flip(),
    );
  }
}

class Way2Flip extends StatefulWidget {
  const Way2Flip({super.key});

  @override
  State<Way2Flip> createState() => _Way2FlipState();
}

class _Way2FlipState extends State<Way2Flip> {
  @override
  Widget build(BuildContext context) {
    return  const FlipWidget(direction: FlipDirection.up,);
  }
}

enum FlipDirection { up, down }

class FlipWidget extends StatefulWidget {
  const FlipWidget({super.key, required this.direction});

  final FlipDirection direction;

  @override
  State<FlipWidget> createState() => _FlipWidgetState();
}

class _FlipWidgetState extends State<FlipWidget> with TickerProviderStateMixin {
  final _perspective = 0.003;
  final _zeroAngle = 0.0001;
  bool? _isReversePhase;
  AnimationController? _controller;
  Animation? _animation;

  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _isReversePhase = true;
              _controller?.reverse();
            }
            if (status == AnimationStatus.dismissed) {
              // _currentValue = _nextValue;
              // _running = false;
            }
          })
          ..addListener(() {
            setState(() {
              // _running = true;
            });
          });
    _animation =
        Tween(begin: _zeroAngle, end: math.pi / 2).animate(_controller!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: (){
            _controller?.reverseDuration?.inMilliseconds;
            _controller?.forward();
          },
          onLongPress: (){
            _controller?.reverse();
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildUpperFlipPanel(),
              // Padding(
              //   padding: EdgeInsets.only(top: 10),
              // ),
              _buildLowerFlipPanel(),
            ],
          ),
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
              ),
            ),
            Transform(
              alignment: Alignment.bottomCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, _perspective)
                ..rotateX((_isReversePhase ?? false)
                    ? _animation?.value
                    : math.pi / 2),
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
                  ..rotateX(_zeroAngle),
                child: Text("1")),
            Transform(
              alignment: Alignment.bottomCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, _perspective)
                ..rotateX((_isReversePhase ?? false) ? math.pi / 2 : _animation?.value),
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
                ..rotateX((_isReversePhase ?? false) ? math.pi / 2 : -_animation?.value),
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
                ..rotateX((_isReversePhase ?? false) ? -_animation?.value : math.pi / 2),
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
