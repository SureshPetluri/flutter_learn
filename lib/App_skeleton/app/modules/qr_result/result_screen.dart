import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'result_controller.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Scan Result"),
        ),
        body: GetBuilder<ResultController>(
          builder: (controller) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("result is ${controller.result?.code}"),
                ElevatedButton(
                    onPressed: () {
                      controller.submit(context);
                    },
                    child: const Text("Scan"))
              ],
            ),
          ),
        ));
  }
}
