import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/custom_styles_dec.dart';
import '../../../utils/country_code_bottom_sheet.dart';
import '../../../utils/dialog.dart';
import '../../../utils/form_utils.dart';
import '../../../utils/utils.dart';
import '../../../widgets/app_stepper.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_textform_field.dart';
import '../../../widgets/custom_widgets.dart';
import '../../../widgets/responsive_mobile_web_tab.dart';
import 'farmer_form_controller.dart';

class FarmerFormScreen extends StatelessWidget {
  FarmerFormScreen({super.key});

  final FarmerFormController controller = Get.put(FarmerFormController());

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
              Get.offAllNamed(AppRoutes.farmerSignUp);
            } else {
              Get.back();
            }
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text("Farmer Form"),
      ),
      backgroundColor: Colors.white,
      body: AppStepper(
        stepperWeb:Get.width > 720? true:false,
        info: ["Formar Info","Address","Bank","AAdhar","Pan"],
        child: [Column(
          children: [
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
                                pickImageFromCameraOrGallery(context,
                                    controller.imageBytes, controller.image);
                                /*pickImage([
                                          'jpg',
                                          'jpeg',
                                          'webp',
                                          'png',
                                        ], controller.imageBytes,
                                            controller.image);*/
                              },
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                              pickImageFromCameraOrGallery(context,
                                  controller.imageBytes, controller.image);
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
                FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]*$')),
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
                        padding: const EdgeInsets.only(left: 3.0, right: 5.0),
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
            Container(
              width: 300,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey),
                ),
              ),
              child: Obx(
                () => CustomDropdown<int>(
                  onChange: (int? value, int index) {
                    // authController.setVehicleIndex(value, true);
                  },
                  dropdownButtonStyle: DropdownButtonStyle(
                    height: 45,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10,
                    ),
                    primaryColor: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                  dropdownStyle: DropdownStyle(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(10.0),
                    padding: const EdgeInsets.all(5.0),
                  ),
                  items: controller.vehicleList.value ?? [],
                  child: const Text(
                    'Select District',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            sizedBoxH40(),
            ElevatedButton(
                onPressed: () {
                  showCustomSnackBar("message", isError: false);
                  showAlertDialog(context,
                      title: "Suresh",
                      content: "sjdhfbgwou4rv",
                      actionWidgets: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                      ]);
                },
                child: Text("AlertDialog"))
          ],
        ),Column(
          children: [
            CustomTextFormField(
              formController: controller.nameController,
              hintText: "Full Name",
              maxLength: 30,
              validators: FormUtils.nullOnFieldNotEmpty,
              prefixWidget: const Icon(Icons.person),
              inputFormatter: [
                FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]*$')),
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
                        padding: const EdgeInsets.only(left: 3.0, right: 5.0),
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
            Container(
              width: 300,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey),
                ),
              ),
              child: Obx(
                    () => CustomDropdown<int>(
                  onChange: (int? value, int index) {
                    // authController.setVehicleIndex(value, true);
                  },
                  dropdownButtonStyle: DropdownButtonStyle(
                    height: 45,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10,
                    ),
                    primaryColor: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                  dropdownStyle: DropdownStyle(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(10.0),
                    padding: const EdgeInsets.all(5.0),
                  ),
                  items: controller.vehicleList.value ?? [],
                  child: const Text(
                    'Select District',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            sizedBoxH40(),
            ElevatedButton(
                onPressed: () {
                  showCustomSnackBar("message", isError: false);
                  showAlertDialog(context,
                      title: "Suresh",
                      content: "sjdhfbgwou4rv",
                      actionWidgets: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                      ]);
                },
                child: Text("AlertDialog"))
          ],
        ),Column(
          children: [
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
                          pickImageFromCameraOrGallery(context,
                              controller.imageBytes, controller.image);
                          /*pickImage([
                                          'jpg',
                                          'jpeg',
                                          'webp',
                                          'png',
                                        ], controller.imageBytes,
                                            controller.image);*/
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                        pickImageFromCameraOrGallery(context,
                            controller.imageBytes, controller.image);
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
                        padding: const EdgeInsets.only(left: 3.0, right: 5.0),
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
            Container(
              width: 300,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey),
                ),
              ),
              child: Obx(
                    () => CustomDropdown<int>(
                  onChange: (int? value, int index) {
                    // authController.setVehicleIndex(value, true);
                  },
                  dropdownButtonStyle: DropdownButtonStyle(
                    height: 45,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10,
                    ),
                    primaryColor: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                  dropdownStyle: DropdownStyle(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(10.0),
                    padding: const EdgeInsets.all(5.0),
                  ),
                  items: controller.vehicleList.value ?? [],
                  child: const Text(
                    'Select District',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            sizedBoxH40(),
            ElevatedButton(
                onPressed: () {
                  showCustomSnackBar("message", isError: false);
                  showAlertDialog(context,
                      title: "Suresh",
                      content: "sjdhfbgwou4rv",
                      actionWidgets: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                      ]);
                },
                child: Text("AlertDialog"))
          ],
        ),Column(
          children: [
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
                          pickImageFromCameraOrGallery(context,
                              controller.imageBytes, controller.image);
                          /*pickImage([
                                          'jpg',
                                          'jpeg',
                                          'webp',
                                          'png',
                                        ], controller.imageBytes,
                                            controller.image);*/
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                        pickImageFromCameraOrGallery(context,
                            controller.imageBytes, controller.image);
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
                FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]*$')),
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
                        padding: const EdgeInsets.only(left: 3.0, right: 5.0),
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
            Container(
              width: 300,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey),
                ),
              ),
              child: Obx(
                    () => CustomDropdown<int>(
                  onChange: (int? value, int index) {
                    // authController.setVehicleIndex(value, true);
                  },
                  dropdownButtonStyle: DropdownButtonStyle(
                    height: 45,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10,
                    ),
                    primaryColor: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                  dropdownStyle: DropdownStyle(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(10.0),
                    padding: const EdgeInsets.all(5.0),
                  ),
                  items: controller.vehicleList.value ?? [],
                  child: const Text(
                    'Select District',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            sizedBoxH40(),
            ElevatedButton(
                onPressed: () {
                  showCustomSnackBar("message", isError: false);
                  showAlertDialog(context,
                      title: "Suresh",
                      content: "sjdhfbgwou4rv",
                      actionWidgets: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                      ]);
                },
                child: Text("AlertDialog"))
          ],
        ),Column(
          children: [
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
                          pickImageFromCameraOrGallery(context,
                              controller.imageBytes, controller.image);
                          /*pickImage([
                                          'jpg',
                                          'jpeg',
                                          'webp',
                                          'png',
                                        ], controller.imageBytes,
                                            controller.image);*/
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                        pickImageFromCameraOrGallery(context,
                            controller.imageBytes, controller.image);
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
                FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]*$')),
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
                        padding: const EdgeInsets.only(left: 3.0, right: 5.0),
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
            Container(
              width: 300,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey),
                ),
              ),
              child: Obx(
                    () => CustomDropdown<int>(
                  onChange: (int? value, int index) {
                    // authController.setVehicleIndex(value, true);
                  },
                  dropdownButtonStyle: DropdownButtonStyle(
                    height: 45,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10,
                    ),
                    primaryColor: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                  dropdownStyle: DropdownStyle(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(10.0),
                    padding: const EdgeInsets.all(5.0),
                  ),
                  items: controller.vehicleList.value ?? [],
                  child: const Text(
                    'Select District',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        )],
      ),
    );
  }
}
