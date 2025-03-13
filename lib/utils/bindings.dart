import 'package:get/get.dart';
import 'package:smart_farm/controller/green_capture/home_controller.dart';
import 'package:smart_farm/controller/main_controller.dart';

class InitialBindings extends Bindings {
  @override
  Future dependencies() async {
    await mainController();
    await homeController();
    // await greenCaptureController();
  }

  Future<void> mainController() async {
    Get.put(MainController());
  }

  Future<void> homeController() async {
    Get.put(HomeController());
  }
}

// class CameraBindings extends Bindings {
//   @override
//   Future dependencies() async {
//     await takePictureController();
//   }

//   Future<void> takePictureController() async {
//     Get.put(TakePictureController());
//   }
// }
