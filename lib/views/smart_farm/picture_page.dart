// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/api/api_service.dart';
import 'package:smart_farm/config/app_colors.dart';
import 'package:smart_farm/controller/main_controller.dart';
import 'package:smart_farm/objs/image_detect.dart';
import 'package:smart_farm/utils/tool.dart';
import 'package:smart_farm/widgets/customWidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PicturePage extends StatelessWidget {
  const PicturePage({super.key});

  void detectPicture() async {
    try {
      Get.find<MainController>().detecting.value = true;

      Get.find<MainController>().listImageDetect.value = [];
      String result = await postImage(
        imageFileToBase64(Get.find<MainController>().image.value.path),
        Get.find<MainController>().image.value.name,
      );

      Map<String, dynamic> jsonResponse = jsonDecode(result);
      // print(jsonResponse['results']);

      for (var item in jsonResponse['results']) {
        Get.find<MainController>().listImageDetect.add(
          ImageDetect.fromJson({
            'image': item['image'],
            'prediction': item['prediction'],
          }),
        );
      }
      Get.find<MainController>().detecting.value = false;
      Get.find<MainController>().clickDetect.value = true;
    } on Exception catch (e) {
      log('Detach Image Error: $e');
    }
  }

  void choosePicture() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.find<MainController>().image.value = pickedImage;
      // Get.find<MainController>().result.value = [];
      Get.find<MainController>().listImageDetect.value = [];
      Get.find<MainController>().clickDetect.value = false;
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          buildBtnPart(context),
          const Divider(),
          Center(
            child: Obx(() {
              if (Get.find<MainController>().image.value.path != '') {
                // if (Get.find<MainController>().listImageDetect.isEmpty) {
                if (!Get.find<MainController>().clickDetect.value) {
                  return buildResultPart();
                }
                return buildResultInfoPart();
              }
              return const Text('Vui lòng chọn ảnh hoặc chụp ảnh mới!');
            }),
          ),
        ],
      ),
    );
  }

  Widget buildBtnPart(BuildContext context) => Container(
    // height: Get.height * 0.2,
    margin: EdgeInsets.symmetric(vertical: Get.height * 0.01),
    child: Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomWidget.homeBtn(
            onTap:
                Get.find<MainController>().detecting.value == true
                    ? () {}
                    : () async {
                      final image = await ImagePicker().pickImage(
                        source: ImageSource.camera,
                        imageQuality: 90,
                        preferredCameraDevice: CameraDevice.front,
                      );
                      if (image != null) {
                        Get.find<MainController>().clickDetect.value = false;
                        Get.find<MainController>().image.value = image;
                        Get.find<MainController>().listImageDetect.value = [];
                      }
                      // Get.topredictiond('/take_picture');
                    },
            title: 'Start Camera',
            icon: Icons.camera_alt,
          ),
          SizedBox(height: Get.height * 0.02),
          CustomWidget.homeBtn(
            onTap:
                Get.find<MainController>().detecting.value == true
                    ? () {}
                    : choosePicture,
            title: 'Open Gallery',
            icon: Icons.photo,
          ),
        ],
      );
    }),
  );

  Widget buildResultPart() => Container(
    // height: Get.height * 0.72,
    // decoration: BoxDecoration(),
    margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.file(
            File(Get.find<MainController>().image.value.path),
            height: Get.height * 0.6,
            width: Get.width * 0.9,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: Get.height * 0.03),
        Obx(() {
          return CustomWidget.homeBtn(
            title: 'DETECT',
            textSize: 20,
            height: Get.height * 0.06,
            width: Get.width * 0.9,
            onTap:
            //  Get.find<MainController>().detecting.value
            //     ? null
            //     :
            () async {
              detectPicture();
            },
            loadingWidget:
                Get.find<MainController>().detecting.value == true
                    ? Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: AppColors.white,
                        size: 30,
                      ),
                    )
                    : null,
          );
        }),
      ],
    ),
  );

  Widget buildResultInfoPart() => Container(
    // height: Get.height * 0.72,
    // decoration: BoxDecoration(),
    margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: Get.width * 0.45,
              child: const Text(
                'Hình ảnh Gốc',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.file(
                File(Get.find<MainController>().image.value.path),
                height: Get.height * 0.2,
                width: Get.width * 0.45,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        const Divider(),
        Column(
          children:
              Get.find<MainController>().listImageDetect.map((item) {
                return Column(
                  children: [
                    //prediction
                    Container(
                      alignment: Alignment.topCenter,
                      height: Get.height * 0.05,
                      child: Text(
                        'Dự đoán: ${Tool.getVietnamese(item.prediction)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    //  image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.memory(
                        base64Decode(item.image),
                        height: Get.height * 0.45,
                        width: Get.width * 0.9,
                        fit: BoxFit.cover,
                      ),
                    ),

                    SizedBox(width: Get.width * 0.5, child: const Divider()),
                    // SizedBox(
                    //   height: Get.height * 0.03,
                    // ),
                    // Obx(() {
                    //   return CustomWidget.homeBtn(
                    //     title: 'DETECT',
                    //     textSize: 20,
                    //     height: Get.height * 0.06,
                    //     width: Get.width * 0.9,
                    //     onTap: () async {
                    //       detectPicture();
                    //     },
                    //     loadingWidget:
                    //         Get.find<MainController>().detecting.value == true
                    //             ? Center(
                    //                 child: LoadingAnimationWidget.staggeredDotsWave(
                    //                     color: AppColors.white, size: 30),
                    //               )
                    //             : null,
                    //   );
                    // }),
                    // SizedBox(
                    //   height: Get.height * 0.03,
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       CustomWidget.homeBtn(
                    //           onTap: () {
                    //             precautionDialog(item);
                    //           },
                    //           color: AppColors.infoColor,
                    //           title: 'Precaution',
                    //           textSize: 20,
                    //           height: Get.height * 0.06,
                    //           width: Get.width * 0.4),
                    //       CustomWidget.homeBtn(
                    //           onTap: reportDialog,
                    //           color: AppColors.dangerColor,
                    //           textColor: AppColors.black,
                    //           title: 'Report',
                    //           textSize: 20,
                    //           height: Get.height * 0.06,
                    //           width: Get.width * 0.4),
                    //     ],
                    //   ),
                    // ),
                  ],
                );
              }).toList(),
        ),
        const Divider(),
      ],
    ),
  );

  void precautionDialog(ImageDetect item) {
    Get.dialog(
      AlertDialog(
        title: Text(item.prediction),
        content: const Text('Disease info and precaution will be showed here!'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void reportDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Report'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tell us what wrong!'),
            TextField(
              decoration: InputDecoration(
                hintText: 'Give us the true prediction of this disease!',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Sent'),
          ),
        ],
      ),
    );
  }
}

// // Hàm gọi khi người dùng chụp ảnh hoặc chọn ảnh từ thư viện
// void captureOrSelectImage() async {
//   // Code để chụp ảnh hoặc chọn ảnh từ thư viện ở đây
//   // Sau khi có được ảnh, gọi hàm postImage và chờ kết quả từ server
//   File? imageFile =
//       await getImage(); // Hàm này để chụp ảnh hoặc chọn ảnh từ thư viện
//   if (imageFile != null) {
//     String result = await postImage(imageFile);
//     print(result); // In kết quả từ server
//   }
// }
