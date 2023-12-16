import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerController extends GetxController {
  Barcode? result;
  QRViewController? qrController;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isOver = true;

  void onQRViewCreated(QRViewController controller) {
    qrController = controller;
    update();
    controller.scannedDataStream.listen((scanData) {
      if (isOver) {
        isOver = false;
        Get.back(result: scanData);
        update();
        // Navigator.pop(context, );
      }
    });
  }

  void onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  flashCheck() async {
    await qrController?.toggleFlash();
    update();
  }

  flipCam() async {
    await qrController?.flipCamera();
    update();
  }
}
