import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farm_ai/controller/green_capture/image_management_controller.dart';
import 'package:farm_ai/views/data_views/add_data_screen.dart';
import 'package:farm_ai/views/data_views/management_image_screen.dart';
import 'package:farm_ai/widgets/progress.dart';

class DataPage extends StatelessWidget {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ImageManagementController());
    // Get.put(HomeController());
    ImageManagementController imageManagementController =
        Get.find<ImageManagementController>();
    // HomeController homeController = Get.find<HomeController>();

    return Obx(() {
      return imageManagementController.loading.value
          //  ||
          //         homeController.loading.value
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
