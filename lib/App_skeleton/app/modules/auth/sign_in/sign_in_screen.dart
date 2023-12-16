import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../themes/custom_styles_dec.dart';
import '../../../utils/form_utils.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_menu_text.dart';
import '../../../widgets/custom_textform_field.dart';
import '../../../widgets/custom_widgets.dart';
import 'sign_in_controller.dart';


class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}):super(key: key);

  final SignInController controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 70.0),
            child: Center(
              child: CustomMenuText(
                items: [
                  MenuDropdownItem(
                    onChange: () => controller.submit(context),
                    text: "Farmers List",
                  ),
                  MenuDropdownItem(
                    onChange: () => controller.submit(context),
                    text: "Create Farmer",
                  ),
                  MenuDropdownItem(
                    onChange: () => controller.submit(context),
                    text: "ejhfgeruyfe",
                  )
                ],
                child: Text("Farmer"),
              ),
            ),
          )
        ],
        // leading: T,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: Stack(
            children: [
              const Positioned(
                left: 0.0,
                right: 0.0,
                top: 50,
                child: Text(
                  "Welcome to Smart Crop",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28),
                ),
              ),
              // sizedBoxH40(),
              Align(
                alignment: Alignment(0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Card(
                      color: Colors.white,
                      elevation: Get.width > 500 ? 10 : 0.0,
                      margin: EdgeInsets.zero,
                      child: Container(
                        width: Get.width > 500 ? 500 : Get.width,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              sizedBoxH20(),
                              CustomTextFormField(
                                hintText: "Mobile/Email/Aadhar",
                                inputFormatter: [
                                  NoLeadingSpaceInputFormatter()
                                ],
                                prefixWidget: Icon(Icons.person),
                                validators: FormUtils.checkLettersOrNumbers,
                                formController: controller.userController,
                              ),
                              sizedBoxH10(),
                              Obx(
                                () => CustomTextFormField(
                                  hintText: "Password",
                                  obscure: controller.isPWD.value,
                                  suffixWidget: IconButton(
                                    icon: Icon(controller.isPWD.value
                                        ? Icons.visibility_off
                                        : Icons.visibility_sharp),
                                    onPressed: () {
                                      controller.isPWD.value =
                                          !controller.isPWD.value;
                                    },
                                  ),
                                  inputFormatter: [
                                    // CardFormatter(sample: "**/**/****",separator: '/'),
                                    NoSpaceInputFormatter()
                                  ],
                                  prefixWidget: const Icon(Icons.password),
                                  validators: FormUtils.nullOnFieldNotEmpty,
                                  formController: controller.passwordController,
                                ),
                              ),
                              sizedBoxH30(),
                              CustomButtonWidget(
                                onTapFunc: () {
                                  controller.submit(context);
                                },
                                child: const Center(child: Text("Sign In")),
                              ),
                              sizedBoxH30(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    sizedBoxH30(),
                    CustomButtonWidget(
                      backgroundColor: Colors.white,
                      elevation: 0.0,
                      splashFactory: NoSplash.splashFactory,
                      onTapFunc: () {
                        Get.toNamed(AppRoutes.farmerSignUp);
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "Join as a ",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16), // Set the text color to blue
                            ),
                            TextSpan(
                              text: "Farmer",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 18), // Set the text color to red
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(() => Text(controller.version.value)),
                  ],
                ),
              ),
              // sizedBoxH40(),
            ],
          ),
        ),
      ),
    );
  }
}
