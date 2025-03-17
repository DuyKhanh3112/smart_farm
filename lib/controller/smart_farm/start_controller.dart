import 'package:get/get.dart';

class StartController extends GetxController {
  @override
  void onInit() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    // Get.offAndToNamed("/home");
    Get.toNamed("/");
    super.onInit();
  }
}
