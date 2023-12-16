import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  CustomButtonWidget({
    Key? key,

    /// function for onPressed events
    required this.onTapFunc,

    ///text for child
    required this.child,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.statesController,
    this.focusNode,
    this.backgroundColor,
    this.elevation,
    this.splashFactory,
  }) : super(key: key);

  final GestureTapCallback onTapFunc;
  ///button child
  final Widget child;

  Function()? onLongPress;
  final void Function(bool)? onHover;
  final void Function(bool)? onFocusChange;
  final Color? backgroundColor;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final double? elevation;
  final MaterialStatesController? statesController;
  final InteractiveInkFeatureFactory? splashFactory;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color?>(backgroundColor),
        elevation: MaterialStateProperty.all<double?>(elevation),
        splashFactory: splashFactory,
      ),
      onPressed: () {
        onTapFunc();
      },
      /// based on screen size we change button width
      child: SizedBox(
        width: MediaQuery.of(context).size.width > 500
            ? (MediaQuery.of(context).size.width * 0.3)
            : (MediaQuery.of(context).size.width - 60),
        height: 40,
        child: Center(child: child),
      ),
    );
  }
}
