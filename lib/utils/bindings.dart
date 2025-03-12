import 'package:get/get.dart';
import 'package:smart_farm/controller/main_controller.dart';

class InitialBindings extends Bindings {
  @override
  Future dependencies() async {
    await mainController();
    // await greenCaptureController();
  }

  Future<void> mainController() async {
    Get.put(MainController());
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
