import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_button.dart';
import 'custom_widgets.dart';

class AppStepper extends StatefulWidget {
  AppStepper(
      {super.key,
      this.stepperWeb = false,
      required this.child,
      required this.info});

  bool stepperWeb;
  final List<Widget> child;
  final List<String> info;

  @override
  State<AppStepper> createState() => _AppStepperState();
}

class _AppStepperState extends State<AppStepper> {
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.stepperWeb = Get.width > 720 ? true : false;
      setState(() {});
    });
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 20.0),
        alignment: Alignment.center,
        width: Get.width > 1024 ? 1024 : Get.width,
        child: widget.info.length != widget.child.length
            ? const Center(child: Text("Side Widgets and Children are Same"))
            : !widget.stepperWeb
                ? Column(
                    children: [
                      SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              widget.info.length,
                              (index) => Container(
                                    height: 40,
                                    width: 40,
                                    constraints: const BoxConstraints(
                                        maxHeight: 40, maxWidth: 40),
                                    margin: const EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: activeIndex >= index
                                            ? Colors.green
                                            : Colors.orange,
                                      ),
                                    ),
                                    child: Center(child: Text("${index + 1}")),
                                  )),
                        ),
                      ),
                      sizedBoxH30(),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: Column(
                            children: [
                              widget.child[activeIndex],
                              buildRow(widget.info)
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                              widget.info.length,
                              (index) => Row(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        constraints: const BoxConstraints(
                                            maxHeight: 40, maxWidth: 40),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color: activeIndex >= index
                                                ? Colors.green
                                                : Colors.orange,
                                          ),
                                        ),
                                        child:
                                            Center(child: Text("${index + 1}")),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20.0),
                                        child: Text(widget.info[index]),
                                      ),
                                    ],
                                  )),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: Column(
                            children: [
                              widget.child[activeIndex],
                              buildRow(widget.info)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  Row buildRow(List<String> info) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        BouncingButton(
          onTap: () {
            if (activeIndex > 0) {
              activeIndex--;
              setState(() {});
            }
          },
          buttonWidth: Get.width * 0.2,
          text: 'Back',
        ),
        BouncingButton(
          onTap: () {
            if (info.length - 1 > activeIndex) {
              activeIndex++;
              setState(() {});
            }
          },
          buttonWidth: Get.width * 0.2,
          text: "Continue",
        ),
      ],
    );
  }
}
