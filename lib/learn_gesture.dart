import 'dart:async';
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
      home: MyHomePage(title: 'Flip Animation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final digits = [
    0,
    1,
    2,
    3,
    4,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FlipPanel.builder(
          direction: FlipDirection.up,
          itemBuilder: (context, index) => Container(
            alignment: Alignment.center,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height -
                (AppBar().preferredSize.height + 1),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      digits.add(1);
                    });
                  },
                  child: Image.network(
                    'block_chat/images/tree.jpg',
                    fit: BoxFit.fill,
                    height: (MediaQuery.sizeOf(context).height -
                            (AppBar().preferredSize.height + 1)) *
                        0.35,
                    width: MediaQuery.sizeOf(context).width,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      digits.add(1);
                    });
                  },
                  child: Container(
                    color: Colors.green,
                    height: (MediaQuery.sizeOf(context).height -
                            (AppBar().preferredSize.height + 1)) *
                        0.62,
                    child: Text(
                      "In Flutter, the Text widget has a property called overflow, which allows you to handle text overfloIn Flutter, the Text widget has a property called overflow, which allows you to In Flutter, the Text widget has a property called overflow, which allows you to handle In Flutter, the Text widget has a property called overflow, which allows you to In Flutter, the Text widget has a property called overflow, which allows you to handle In Flutter, the Text widget has a property called overflow, which allows you to handle text In Flutter, the Text widget has a property called overflow, which allows you to handle text overfloIn Flutter, the Text widget has a property called overflow, which allows you to handle text overflooverfloIn Flutter, the Text widget has a property called overflow, which allows you to handle text overflotext overfloIn Flutter, the Text widget has a property called overflow, which allows you to handle text overflohandle text overfloIn Flutter, the Text widget has a property called overflow, which allows you to handle text overflotext overfloIn Flutter, the Text widget has a property called overflow, which allows you to handle text overflohandle text overfloIn Flutter, the Text widget has a property called overflow, which allows you to handle text overfloIn Flutter, the Text widget has a property called overflow, which allows you to handle text overfloIn Flutter, the Text widget has a property called overflow, which allows you to handle text overfloIn Flutter, the Text widget has a property called overflow, which allows you to handle text overflow when the text exceeds the boundaries of its container. There are various options you can choose from to handle text overflow based on your requirements. Here are some common values for the overflow property:",
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          // decoration: Textd,
                          color: Colors.yellow),
                    ),
                  ),
                ),
              ],
            ),
          ),
          itemsCount: digits.length,
          period: const Duration(milliseconds: 4000),
          loop: -1,
          duration: Duration(milliseconds: 2000),
        ),
      ),
    );
  }
}

/// Signature for a function that creates a widget for a given index, e.g., in a
/// list.
typedef Widget IndexedItemBuilder(BuildContext, int);

/// Signature for a function that creates a widget for a value emitted from a [Stream]
typedef Widget StreamItemBuilder<T>(BuildContext, T);

/// A widget for flip panel with built-in animation
/// Content of the panel is built from [IndexedItemBuilder] or [StreamItemBuilder]
///
/// Note: the content size should be equal
enum FlipDirection { up, down }

class FlipPanel<T> extends StatefulWidget {
  final IndexedItemBuilder? indexedItemBuilder;
  final int? itemsCount;
  final Duration? period;
  final Duration? duration;
  final int? loop;
  final int? startIndex;
  final T? initValue;
  // final double? spacing;
  final FlipDirection? direction;

  const FlipPanel({
    Key? key,
    this.indexedItemBuilder,
    this.itemsCount,
    this.period,
    this.duration,
    this.loop,
    this.startIndex,
    this.initValue,
    // this.spacing,
    this.direction,
  }) : super(key: key);

  /// Create a flip panel from iterable source
  /// [itemBuilder] is called periodically in each time of [period]
  /// The animation is looped in [loop] times before finished.
  /// Setting [loop] to -1 makes flip animation run forever.
  /// The [period] should be two times greater than [duration] of flip animation,
  /// if not the animation becomes jerky/stuttery.
  FlipPanel.builder({
    Key? key,
    required IndexedItemBuilder itemBuilder,
    required this.itemsCount,
    required this.period,
    this.duration = const Duration(milliseconds: 500),
    this.loop = 1,
    this.startIndex = 0,
    // this.spacing = 0.5,
    this.direction = FlipDirection.up,
  })  : assert(itemsCount != null),
        assert(startIndex! < itemsCount!),
        assert(period == null ||
            period.inMilliseconds >= 2 * duration!.inMilliseconds),
        indexedItemBuilder = itemBuilder,
        initValue = null,
        super(key: key);


  @override
  _FlipPanelState<T> createState() => _FlipPanelState<T>();
}

class _FlipPanelState<T> extends State<FlipPanel> with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation? _animation;
  int? _currentIndex;
  bool? _isReversePhase;
  bool? _running;
  final _perspective = 0.0001;
  final _zeroAngle = 0.0000; // There's something wrong in the perspective transform, I use a very small value instead of zero to temporarily get it around.
  int? _loop;
  T? _currentValue, _nextValue;
  Timer? _timer;
  StreamSubscription<T>? _subscription;

  Widget? _child1, _child2;
  Widget? _upperChild1, _upperChild2;
  Widget? _lowerChild1, _lowerChild2;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.startIndex;
    _isReversePhase = false;
    _running = false;
    _loop = 0;

    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _isReversePhase = true;
           _controller?.reverse();
        }
        if (status == AnimationStatus.dismissed) {
          _currentValue = _nextValue;
          _running = false;
        }
      })
      ..addListener(() {
        setState(() {
           _running = true;
        });
      });
    _animation =
        Tween(begin: _zeroAngle, end: math.pi / 2).animate(_controller!);

    if (widget.period != null) {
      _timer = Timer.periodic(widget.period!, (_) {
        if ((widget.loop ?? 0) < 0 || (_loop ?? 0) < (widget.loop ?? 0)) {
          if ((_currentIndex ?? 0) + 1 == (widget.itemsCount ?? 0) - 2) {
            _loop = (_loop ?? 0) + 1;
          }
          _currentIndex = ((_currentIndex ?? 0) + 1) % (widget.itemsCount ?? 0);
          _child1 = null;
          _isReversePhase = false;
          _controller?.forward();
        } else {
          _timer?.cancel();
          _currentIndex = (_currentIndex! + 1) % widget.itemsCount!;
          setState(() {
            _running = false;
          });
        }
      });
    }

    if (widget.loop! < 0 || _loop! < widget.loop!) {
      _controller!.forward();
    }
  }

  @override
  void dispose() {
    _controller!.dispose();
    if (_subscription != null) _subscription!.cancel();
    if (_timer != null) _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      _buildChildWidgetsIfNeed(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildUpperFlipPanel(),
        _buildLowerFlipPanel(),
      ],
    );
  }

  void _buildChildWidgetsIfNeed(BuildContext context) {
    Widget makeUpperClip(Widget widget) {
      return  ClipRect(
        child: Align(
          alignment: Alignment.topCenter,
          heightFactor: 0.5,
          child: widget,
        ),
      );
    }

    Widget makeLowerClip(Widget widget) {
      return ClipRect(
        child: Align(
          alignment: Alignment.bottomCenter,
          heightFactor: 0.5,
          child: widget,
        ),
      );
    }

      if (_running!) {
      if (_child1 == null) {
        if (_child2 != null) {
          _child1 = _child2;
        }
        _child2 = null;
        _upperChild1 =
            _upperChild2 != null ? _upperChild2 : makeUpperClip(_child1!);
        _lowerChild1 =
            _lowerChild2 != null ? _lowerChild2 : makeLowerClip(_child1!);
      }
      if (_child2 == null) {
        _child2 =  widget.indexedItemBuilder!(
                context, (_currentIndex! + 1) % widget.itemsCount!);
        _upperChild2 = makeUpperClip(_child2!);
        _lowerChild2 = makeLowerClip(_child2!);
      }
     } else {
      if (_child2 != null) {
        _child1 = _child2;
      } else {
        _child1 =  widget.indexedItemBuilder!(
                context, _currentIndex! % widget.itemsCount!);
      }
      _upperChild1 =
          _upperChild2 != null ? _upperChild2 : makeUpperClip(_child1!);
      _lowerChild1 =
          _lowerChild2 != null ? _lowerChild2 : makeLowerClip(_child1!);
    }
  }

  Widget _buildUpperFlipPanel() => widget.direction == FlipDirection.up
      ? Stack(
          children: [
            Transform(
                alignment: Alignment.bottomCenter,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, _perspective)
                  ..rotateX(_zeroAngle),
                child: _upperChild1),
            Transform(
              alignment: Alignment.bottomCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, _perspective)
                ..rotateX(_isReversePhase! ? _animation!.value : math.pi / 2),
              child: _upperChild2,
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
                child: _upperChild2),
            Transform(
              alignment: Alignment.bottomCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, _perspective)
                ..rotateX(_isReversePhase! ? math.pi / 2 : _animation!.value),
              child: _upperChild1,
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
                child: _lowerChild2),
            Transform(
              alignment: Alignment.topCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, _perspective)
                ..rotateX(_isReversePhase! ? math.pi / 2 : -_animation!.value),
              child: _lowerChild1,
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
                child: _lowerChild1),
            Transform(
              alignment: Alignment.topCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, _perspective)
                ..rotateX(_isReversePhase! ? -_animation!.value : math.pi / 2),
              child: _lowerChild2,
            )
          ],
        );
}
