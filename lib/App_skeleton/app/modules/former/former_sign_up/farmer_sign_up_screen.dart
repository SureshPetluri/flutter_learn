import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../themes/custom_styles_dec.dart';
import '../../../utils/country_code_bottom_sheet.dart';
import '../../../utils/form_utils.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textform_field.dart';
import '../../../widgets/custom_widgets.dart';
import '../../../widgets/responsive_mobile_web_tab.dart';
import 'farmer_sign_up_controller.dart';

class FarmerSignUpScreen extends StatelessWidget {
  FarmerSignUpScreen({super.key});

  final FarmerSignUpController controller = Get.put(FarmerSignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: Colors.white,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            print("back ..${Get.back.isBlank}");
            if (!Responsive.isMobile(context) && kIsWeb) {
              Get.offAllNamed(AppRoutes.signIn);
            } else {
              Get.back();
            }
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text("Farmer SignUp"),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Card(
          color: Colors.white,
          elevation: Get.width > 500 ? 10 : 0.0,
          margin: EdgeInsets.zero,
          child: Container(
            width: Get.width > 500 ? 500 : Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: controller.formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    sizedBoxH40(),
                    Obx(
                      () => Stack(
                        children: [
                          /*CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.grey,
                            child: controller.imageBytes.value.isNotEmpty
                                ? ClipOval(
                                    child: Image.memory(
                                      controller.imageBytes.value,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const SizedBox(),
                          )*/
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(9.0),
                              child: controller.imageBytes.value.isNotEmpty
                                  ? Image.memory(
                                      controller.imageBytes.value,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    )
                                  : InkWell(
                                      onTap: () {
                                        pickImageFromCameraOrGallery(
                                            context,
                                            controller.imageBytes,
                                            controller.image);
                                        /*pickImage([
                                          'jpg',
                                          'jpeg',
                                          'webp',
                                          'png',
                                        ], controller.imageBytes,
                                            controller.image);*/
                                      },
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.camera_alt_rounded),
                                          Text("Upload Profile Picture",
                                              textAlign: TextAlign.center)
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                          controller.imageBytes.value.isNotEmpty
                              ? Positioned(
                                  left: -1.0,
                                  bottom: -1.0,
                                  child: IconButton(
                                    color: Colors.blue,
                                    onPressed: () {
                                      pickImageFromCameraOrGallery(
                                          context,
                                          controller.imageBytes,
                                          controller.image);
                                      /*pickImage([
                                        'jpg',
                                        'jpeg',
                                        'webp',
                                        'png',
                                      ], controller.imageBytes,
                                          controller.image);*/
                                    },
                                    icon: const Icon(
                                      Icons.mode_edit_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink()
                        ],
                      ),
                    ),
                    sizedBoxH40(),
                    CustomTextFormField(
                      formController: controller.nameController,
                      hintText: "Full Name",
                      maxLength: 30,
                      validators: FormUtils.nullOnFieldNotEmpty,
                      prefixWidget: const Icon(Icons.person),
                      inputFormatter: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^[a-zA-Z\s]*$')),
                        NoLeadingSpaceInputFormatter()
                      ],
                    ),
                    sizedBoxH10(),
                    CustomTextFormField(
                      formController: controller.mobileController,
                      hintText: "Phone",
                      validators: FormUtils.fieldIsMobile,
                      prefixWidget: InkWell(
                        onTap: () {
                          showCountryCodePicker(
                              context: context,
                              allCountryCodes: controller.allCountryCodes,
                              countrySearchController:
                                  controller.countrySearchController,
                              countryCode: controller.countryCode,
                              countryImage: controller.countryImage);
                        },
                        child: Obx(
                          () => Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                controller.countryImage.value ?? "",
                                package: 'country_code_picker',
                                width: 32.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 3.0, right: 5.0),
                                child: Text(controller.countryCode.value),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 8.0),
                                height: 25,
                                width: 2,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                      // suffixWidget: const Icon(Icons.mob),
                      inputFormatter: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    sizedBoxH10(),
                    CustomTextFormField(
                      formController: controller.emailController,
                      hintText: "Email",
                      validators: FormUtils.fieldIsEmail,
                      prefixWidget: const Icon(Icons.email_sharp),
                      inputFormatter: [NoSpaceInputFormatter()],
                    ),
                    sizedBoxH10(),
                    Obx(
                      () => CustomTextFormField(
                        formController: controller.pWDController.value,
                        hintText: "Password",
                        obscure: controller.isPWD.value,
                        validators: FormUtils.fieldIsPw,
                        prefixWidget: const Icon(Icons.password),
                        suffixWidget: controller.pWDController.value.text.isNotEmpty ? IconButton(
                          icon: Icon(controller.isPWD.value
                              ? Icons.visibility_off
                              : Icons.visibility_sharp),
                          onPressed: () {
                            controller.isPWD.value = !controller.isPWD.value;
                          },
                        ):const SizedBox.shrink(),
                        inputFormatter: [NoSpaceInputFormatter()],
                      ),
                    ),
                    sizedBoxH10(),
                    Obx(
                      () => CustomTextFormField(
                        formController: controller.cPWDController,
                        hintText: "Conform Password",
                        obscure: controller.isPWD.value,
                        validators: (e) {
                          if (controller.cPWDController.text.isEmpty) {
                            return "Can't be empty";
                          } else if (controller.pWDController.value.text !=
                              controller.cPWDController.text) {
                            return "Password and ConformPassword should be Same";
                          } else {
                            return null;
                          }
                        },
                        prefixWidget: const Icon(Icons.password),
                        suffixWidget: IconButton(
                          icon: Icon(controller.isPWD.value
                              ? Icons.visibility_off
                              : Icons.visibility_sharp),
                          onPressed: () {
                            controller.isPWD.value = !controller.isPWD.value;
                          },
                        ),
                        inputFormatter: [NoSpaceInputFormatter()],
                      ),
                    ),
                    sizedBoxH20(),
                    CustomButtonWidget(
                      onTapFunc: () => controller.submitSignUp(context),
                      child: const Center(
                          child: Text(
                        "Register",
                      )),
                    ),
                    sizedBoxH40(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
