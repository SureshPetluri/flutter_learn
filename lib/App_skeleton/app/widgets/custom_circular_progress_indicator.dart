
import 'package:flutter/material.dart';

import 'app_network_image.dart';

class AppIndefiniteProgressDialog extends StatefulWidget {
  const AppIndefiniteProgressDialog({Key? key}) : super(key: key);

  @override
  _AppIndefiniteProgressDialogState createState() =>
      _AppIndefiniteProgressDialogState();
}

class _AppIndefiniteProgressDialogState
    extends State<AppIndefiniteProgressDialog>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController =  AnimationController(
      vsync: this,
      duration:  Duration(seconds: 1),
    );

    animationController!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 80,
            width: 80,
            child: const CircularProgressIndicator(color: Colors.blue,),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: networkImage(
                imageUrl: 'https://polytokdev.pages.dev/logos/polytok.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }
}
