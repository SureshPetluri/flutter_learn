import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../qr_code_scanner/scanner_screen.dart';

enum DataType { Integer, Double, Map, List, None }

class ResultController extends GetxController {
  Barcode? result;
  bool isScan = false;

  Future<void> submit(BuildContext context) async {
    if (!kIsWeb) {
      result = await Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ScannerScreen()));
      if (DataType.Map != checkDataType(result?.code ?? "")) {
        isScan = await dialog(context);
        if (isScan == true) {
          await submit(context);
        }
      }
      update();
    }
  }

  DataType checkDataType(String input) {
    if (int.tryParse(input) != null) {
      return DataType.Integer;
    } else if (double.tryParse(input) != null) {
      return DataType.Double;
    } else {
      try {
        var decodedMap = json.decode(input);
        if (decodedMap is Map) {
          return DataType.Map;
        }
      } catch (e) {
        // Not a map
      }
      try {
        var decodedList = json.decode(input);
        if (decodedList is List) {
          return DataType.List;
        }
      } catch (e) {
        // Not a list
      }
      return DataType.None;
    }
  }

  Future<bool> dialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            content: const Text(
              "Please Scan Again ",
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  isScan = true;
                  Navigator.of(context).pop();
                  update();
                },
                child: Text('Ok'),
              ),
              TextButton(
                onPressed: () {
                  isScan = false;
                  update();
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ]);
      },
    );
    return isScan;
  }
}
