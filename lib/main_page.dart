import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/controller/conversation_controller.dart';
import 'package:smart_farm/controller/main_controller.dart';
import 'package:smart_farm/objs/conversation.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    Get.put(ConversationController());
    MainController mainController = Get.find<MainController>();
    ConversationController conversationController =
        Get.find<ConversationController>();

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
          title: Text(
            mainController.titles[mainController.numPage.value],
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          foregroundColor: Colors.white,
          centerTitle: true,
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
          actions:
              mainController.numPage.value == 4
                  ? [
                    PopupMenuButton(
                      icon: Icon(Icons.more_vert),
                      onSelected: (String value) {
                        if (value == 'refresh') {
                          conversationController.conversations.value =
                              <Conversation>[];
                          conversationController.isLoading.value = false;
                          conversationController
                              .currentConver
                              .value = Conversation(
                            created_at: DateTime.now(),
                            question: '',
                            answer: '',
                          );
                        }
                      },
                      itemBuilder:
                          (BuildContext context) => <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: "refresh",
                              child: ListTile(
                                leading: Icon(
                                  Icons.refresh,
                                  color: Colors.green,
                                ),
                                title: Text("Làm mới"),
                              ),
                            ),
                          ],
                    ),
                  ]
                  :[
            
          ],
        ),
        body: mainController.pages[mainController.numPage.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: mainController.numPage.value,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          // selectedIconTheme: IconThemeData(color: Colors.green, size: 28),
          selectedItemColor: Colors.green,
          // unselectedIconTheme: IconThemeData(color: Colors.grey, size: 20),
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
            BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'Dữ liêu'),
            BottomNavigationBarItem(
              // icon: Icon(Icons.photo_camera_back_rounded, size: 30),
              icon: Container(
                width: Get.width * 0.2,
                height: Get.width * 0.2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                  image: DecorationImage(
                    image: AssetImage('assets/images/scan_image.png'),

                    fit: BoxFit.fill,
                  ),
                ),

                padding: EdgeInsets.all(10),
                // child: Icon(
                //   Icons.photo_camera_back_rounded,
                //   color: Colors.white,
                //   size: 30,
                // ),
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
