import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget? mobile;
  final Widget? tablet;
  final Widget? lapTop;
  final Widget? desktop;

  const Responsive({
    Key? key,
    this.mobile,
    this.tablet,
    this.lapTop,
    this.desktop,
  }) : super(key: key);


  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 450;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 710 &&
          MediaQuery.of(context).size.width >= 450;

  static bool isLapTop(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
          MediaQuery.of(context).size.width >= 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // If our width is more than 1100 then we consider it a desktop
      builder: (context, constraints) {
        /// If width it greater then 1100 we consider it as desktop
        if (constraints.maxWidth >= 1100) {
          return desktop!;
        }
        /// If width it less then 1100 and greater then 710 we consider it as lapTop
        else if (constraints.maxWidth >= 710) {
          return lapTop!;
        }
        /// If width it less then 710 and greater then 450 we consider it as tablet
        else if (constraints.maxWidth >= 450) {
          return tablet!;
        }

        /// Or less then that we called it mobile
        else {
          return mobile!;
        }
      },
    );
  }
}
