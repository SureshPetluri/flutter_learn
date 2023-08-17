import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class PinchZoomImage extends StatefulWidget {
  const PinchZoomImage({Key? key}) : super(key: key);

  @override
  State<PinchZoomImage> createState() => _PinchZoomImageState();
}

class _PinchZoomImageState extends State<PinchZoomImage>
    with SingleTickerProviderStateMixin {
  late TransformationController controller;
  late AnimationController animationController;
  Animation<Matrix4>? animation;
  String base =
      "5H2P7ms/LEyafz===";
  String network =
      'https://cdn.firstcry.com/education/2022/04/25155522/1378635314.jpg';
  // final double minScale = 1;
  // final double maxScale = 4;

  OverlayEntry? entry;
  double scale = 1;

  @override
  void initState() {
    controller = TransformationController();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )..addListener(() => controller.value = animation!.value)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          removeOverlay();
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: buildImage(),
    );
  }

  InteractiveViewer buildImage() {
    return InteractiveViewer(
      transformationController: controller,
      panEnabled: false,
      clipBehavior: Clip.none,
      // minScale: minScale,
      // maxScale: maxScale,
      onInteractionStart: (details) {
        if (details.pointerCount < 2) return;
        showOverlay(context);
      },
      onInteractionUpdate: (details) {
        if (entry == null) return;
        scale = details.scale;
        entry?.markNeedsBuild();
      },
      onInteractionEnd: (details) {
        if (scale > 4) {
          resetAnimation();
        }
      },
      child: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: network.split(":").contains('https')
                ? Image.network(
              network,
              fit: BoxFit.cover,
            )
                : Image.memory(
              base64Decode(base.split(',')[1]),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  void resetAnimation() {
    animation = Matrix4Tween(
      begin: controller.value,
      end: Matrix4.identity(),
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );
    animationController.forward(from: 0);
  }

  void showOverlay(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = MediaQuery.of(context).size;
    entry = OverlayEntry(
      builder: (context) {
        // final opacity = ((scale - 1) / (maxScale - 1)).clamp(minScale, maxScale);
        return Stack(
          children: [
            Positioned.fill(
              child: Container(color: Colors.black),
            ),
            Positioned(
              left: offset.dx,
              top: offset.dy,
              width: size.width,
              child: buildImage(),
            ),
          ],
        );
      },
    );

    final overlay = Overlay.of(context)!;
    overlay.insert(entry!);
  }

  void removeOverlay() {
    entry?.remove();
    entry = null;
  }
}

void main() {
  runApp(const MaterialApp(
    home: PinchZoomImage(),
  ));
}
