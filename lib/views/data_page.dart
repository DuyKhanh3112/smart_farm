import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/controller/green_capture/home_controller.dart';
import 'package:smart_farm/controller/green_capture/image_management_controller.dart';
import 'package:smart_farm/objs/image_local.dart';
import 'package:smart_farm/objs/plant.dart';
import 'package:smart_farm/objs/upload_obj.dart';
import 'package:smart_farm/views/data_views/add_data_screen.dart';
import 'package:smart_farm/views/data_views/management_image_screen.dart';
import 'package:smart_farm/views/green_capture/green_capture_page.dart';
import 'package:smart_farm/views/green_capture/image_management_screen.dart';
import 'package:smart_farm/widgets/progress.dart';
import 'package:smart_farm/widgets/widgets.dart';

class DataPage extends StatelessWidget {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ImageManagementController());
    Get.put(HomeController());
    ImageManagementController imageManagementController =
        Get.find<ImageManagementController>();
    HomeController homeController = Get.find<HomeController>();

    return Obx(() {
      List<Rx<ImageLocal>> items = imageManagementController.imageLocalViews;
      List<Rx<UploadObj>> itemsUploadObj = imageManagementController.uploadObjs;
      return imageManagementController.loading.value ||
              homeController.loading.value
          ? const CircularProgress()
          : DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: TabBar(
                tabs: [
                  Tab(text: 'Quản lý hình ảnh'),
                  Tab(text: 'Thêm dữ liệu'),
                ],
              ),
              backgroundColor: Colors.grey[100],
              body: TabBarView(
                children: [ManagementImageScreen(), AddDataScreen()],
              ),
            ),
          );
    });
  }
}
