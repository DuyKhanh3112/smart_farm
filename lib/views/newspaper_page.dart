import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsPaperPage extends StatelessWidget {
  const NewsPaperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: Get.width * 0.03,
                bottom: Get.width * 0.02,
                left: Get.width * 0.02,
                right: Get.width * 0.02,
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Tìm kiếm',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  suffixIcon: InkWell(
                    child: Icon(Icons.cancel, color: Colors.grey),
                    onTap: () {},
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Expanded(
              child: ListView(
                children:
                    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          ],
        ),
      ),
    );
  }
}
