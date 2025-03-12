import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/controller/green_capture/home_controller.dart';
import 'package:smart_farm/controller/green_capture/image_management_controller.dart';
import 'package:smart_farm/controller/main_controller.dart';
import 'package:smart_farm/utils/tool.dart';
import 'package:smart_farm/widgets/dialog/dialog_filter.dart';
import 'package:smart_farm/widgets/drawer.dart';
import 'package:smart_farm/widgets/progress.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    Get.put(HomeController());
    Get.put(ImageManagementController());
    ImageManagementController imageManagementController =
        Get.find<ImageManagementController>();
    MainController mainController = Get.find<MainController>();
    HomeController homeController = Get.find<HomeController>();

    return Obx(() {
      // bool hasInternet = homeController.hasInternet.value;
      // return Scaffold(
      //   appBar: AppBar(
      //     title: Text(mainController.titles[mainController.numPage.value]),
      //     backgroundColor: Tool.appBar_bg,
      //     foregroundColor: Tool.appBar_title,
      //     titleTextStyle: TextStyle(
      //       fontSize: 24,
      //       fontWeight: FontWeight.bold,
      //       color: Tool.appBar_title,
      //     ),
      //     actions:
      //         mainController.numPage.value == 2
      //             ? [
      //               Obx(() {
      //                 bool loadingMore = homeController.loadingMore.value;
      //                 return loadingMore
      //                     ? const CircularProgress()
      //                     : const SizedBox();
      //               }),
      //               IconButton(
      //                 onPressed: () async => dialogFilterImages(),
      //                 icon: const Icon(Icons.filter_alt_rounded),
      //               ),
      //               IconButton(
      //                 onPressed: () async => await homeController.reload(),
      //                 icon: const Icon(Icons.refresh_rounded),
      //               ),
      //             ]
      //             : mainController.numPage.value == 3
      //             ? [
      //               IconButton(
      //                 onPressed:
      //                     () async =>
      //                         await imageManagementController.uploadAllImage(),
      //                 icon: const Icon(Icons.cloud_upload_rounded),
      //               ),
      //             ]
      //             : [],
      //     bottom: PreferredSize(
      //       preferredSize: Size.fromHeight(hasInternet ? 0 : 20),
      //       child:
      //           hasInternet
      //               ? const SizedBox()
      //               : Container(
      //                 padding: const EdgeInsets.only(top: 5, bottom: 5),
      //                 width: Get.width,
      //                 color: Colors.orange.withOpacity(0.8),
      //                 child: const Center(child: Text("Không có kết nối mạng")),
      //               ),
      //     ),
      //   ),
      //   body: mainController.pages[mainController.numPage.value],
      //   drawer: const MainDrawer(),
      // );
      return Scaffold(
        appBar: AppBar(
          title: Container(
            alignment: Alignment.center,
            child: Text(
              mainController.titles[mainController.numPage.value],
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          flexibleSpace: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg_appbar.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: mainController.pages[mainController.numPage.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: mainController.numPage.value,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedIconTheme: IconThemeData(color: Colors.green, size: 28),
          selectedItemColor: Colors.green,
          unselectedIconTheme: IconThemeData(color: Colors.grey, size: 20),
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
            BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'Dữ liêu'),
            BottomNavigationBarItem(
              // icon: Icon(Icons.photo_camera_back_rounded, size: 30),
              icon: Container(
                // width: Get.width * 0.1,
                // height: Get.width * 0.1,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.photo_camera_back_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.newspaper),
              label: 'Tin tức',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.smart_toy),
              label: 'Hỏi AI',
            ),
          ],
          onTap: (value) {
            mainController.numPage.value = value;
          },
        ),
      );
    });
  }
}
