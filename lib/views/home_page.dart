// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/controller/main_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // HomeController homeController = Get.find<HomeController>();
    MainController mainController = Get.find<MainController>();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(
                left: Get.width * 0.02,
                right: Get.width * 0.02,
                top: Get.width * 0.03,
              ),
              padding: EdgeInsets.only(
                left: Get.width * 0.02,
                right: Get.width * 0.02,
                top: Get.width * 0.02,
                bottom: Get.width * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // width: Get.width * 0.6,
                    // alignment: Alignment.centerLeft,
                    child: Text(
                      'Tin tức nông nghiệp',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  InkWell(
                    child: Text(
                      'Xem thêm',
                      style: TextStyle(color: Colors.green),
                    ),
                    onTap: () {
                      mainController.numPage.value = 3;
                    },
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: Get.width * 0.4,
                    width: Get.width * 0.9,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children:
                          [1, 2, 3, 4]
                              .map(
                                (e) => Container(
                                  margin: EdgeInsets.only(
                                    left: Get.width * 0.02,
                                    right: Get.width * 0.02,
                                    top: Get.width * 0.03,
                                  ),
                                  padding: EdgeInsets.only(
                                    left: Get.width * 0.02,
                                    right: Get.width * 0.02,
                                    top: Get.width * 0.02,
                                    bottom: Get.width * 0.02,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: Get.width * 0.2,
                                        height: Get.width * 0.25,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              'https://picsum.photos/200/300',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: Get.width * 0.675,
                                        padding: EdgeInsets.only(
                                          left: Get.width * 0.02,
                                          right: Get.width * 0.02,
                                        ),
                                        decoration: BoxDecoration(),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Binh thuan huong dan nong dan tru sau hai cay trong',
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'Chi cục Trồng trọt và BVTV Bình Thuận khuyến cáo nông dân thăm đồng thường xuyên, phát hiện các loại dịch hại sớm để có biện pháp xử lý kịp thời.',
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ),
              ],
            ),

            Container(
              margin: EdgeInsets.only(
                left: Get.width * 0.02,
                right: Get.width * 0.02,
                top: Get.width * 0.03,
              ),
              padding: EdgeInsets.only(
                left: Get.width * 0.02,
                right: Get.width * 0.02,
                top: Get.width * 0.02,
                bottom: Get.width * 0.02,
              ),
              child: Text(
                'Dự đoán bệnh',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: Get.width * 0.02,
                right: Get.width * 0.02,
                top: Get.width * 0.03,
              ),
              padding: EdgeInsets.only(
                left: Get.width * 0.02,
                right: Get.width * 0.02,
                top: Get.width * 0.02,
                bottom: Get.width * 0.02,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Container(
                    width: Get.width * 0.35,
                    child: Image.asset(
                      'assets/images/doctor.png',
                      width: Get.width * 0.35,
                    ),
                  ),
                  Container(
                    width: Get.width * 0.55,
                    decoration: BoxDecoration(),
                    child: Column(
                      children: [
                        Text(
                          'Tải ảnh hoặc chụp ảnh để dự đoán bệnh',
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            mainController.numPage.value = 2;
                          },
                          child: Text('Chuẩn đoán bệnh'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(
                left: Get.width * 0.02,
                right: Get.width * 0.02,
                top: Get.width * 0.03,
              ),
              padding: EdgeInsets.only(
                left: Get.width * 0.02,
                right: Get.width * 0.02,
                top: Get.width * 0.02,
                bottom: Get.width * 0.02,
              ),
              child: Text(
                'Hỏi đáp với AI',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                mainController.numPage.value = 4;
              },
              child: Container(
                margin: EdgeInsets.only(
                  left: Get.width * 0.02,
                  right: Get.width * 0.02,
                  top: Get.width * 0.03,
                ),
                padding: EdgeInsets.only(
                  left: Get.width * 0.02,
                  right: Get.width * 0.02,
                  top: Get.width * 0.02,
                  bottom: Get.width * 0.02,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.width * 0.2,
                      child: Image.asset(
                        'assets/images/chatbot.png',
                        width: Get.width * 0.2,
                      ),
                    ),
                    Container(
                      width: Get.width * 0.55,
                      decoration: BoxDecoration(),
                      child: Text(
                        'Chat với Chatbot nông nghiệp của chúng tôi để giải đáp thắc mắc',
                        // maxLines: 2,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: Get.width * 0.1,
                      child: Icon(Icons.arrow_forward_ios, color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
