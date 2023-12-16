import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/form_utils.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textform_field.dart';
import '../../widgets/custom_widgets.dart';
import 'ip_controller.dart';

class IPScreen extends StatelessWidget {
  IPScreen({super.key});

  final IPController controller = Get.put(IPController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: Get.width > 700 ?700 :Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                sizedBoxH30(),
                Form(
                  key: controller.formKey,
                  child: Column(
                          children: [
                            Obx(
                              () => buildImageStack(
                                  height: Get.width > 500 ? 250 : 150,
                                  width: Get.width > 500 ? 250 : 150,
                                  imageBytes: controller.imageBytes,
                                  image: controller.image,context: context),
                            ),
                            sizedBoxH30(),
                            CustomTextFormField(
                              labelText: "Title",
                              hintText: "Title",
                              validators:(text)=>FormUtils.validateTextDescription(text,10),
                              formController: controller.titleController,
                              decorationUnderline: false,
                            ),
                            sizedBoxH30(),
                            CustomTextFormField(
                              labelText: "Description",
                              hintText: "Description",
                              validators: (text)=>FormUtils.validateTextDescription(text,250),
                              formController: controller.desController,
                              decorationUnderline: false,
                              maxLines: 10,
                            )
                          ],
                        ),
                ),
                sizedBoxH30(),
                CustomButtonWidget(onTapFunc: () {
                  controller.submit();
                }, child: const Text("Submit")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
