import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/objs/image.dart';
import 'package:smart_farm/objs/plant.dart';
import 'package:smart_farm/controller/green_capture/home_controller.dart';
import 'package:smart_farm/utils/config.dart';
import 'package:smart_farm/widgets/dialog/dialog_filter.dart';
import 'package:smart_farm/widgets/progress.dart';
import 'package:smart_farm/widgets/widgets.dart';
import 'package:intl/intl.dart';

class ManagementImageScreen extends StatelessWidget {
  const ManagementImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    ScrollController _scrollController = ScrollController();
    return Obx(() {
      bool loading = homeController.loading.value;
      bool loadMore = homeController.loadingMore.value;
      List<Rx<ImageDetail>> items = homeController.imageDetailViews;
      return loading
          ? const CircularProgress()
          : NotificationListener(
            onNotification: (notification) {
              if (notification is ScrollEndNotification) {
                if (notification.metrics.extentAfter <= 100 && !loadMore) {
                  homeController.loadMoreImages();
                }
              }

              return false;
            },
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: Get.width * 0.03,
                    bottom: Get.width * 0.02,
                    left: Get.width * 0.02,
                    right: Get.width * 0.02,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Get.width * 0.7,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(40),
                              ),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Tìm kiếm',

                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: Get.width * 0.1,
                            child: IconButton(
                              onPressed: () async => dialogFilterImages(),
                              icon: const Icon(Icons.filter_alt_rounded),
                            ),
                          ),
                          Container(
                            width: Get.width * 0.1,
                            child: IconButton(
                              onPressed:
                                  () async => await homeController.reload(),
                              icon: const Icon(Icons.refresh_rounded),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView(
                    children:
                        items
                            .map(
                              (item) => _Item(
                                item1: item,
                                index: items.indexOf(item),
                              ),
                            )
                            .toList(),
                  ),
                ),
                loadMore ? const CircularProgress() : const SizedBox(height: 0),
              ],
            ),
          );
    });
  }
}

class _Item extends StatelessWidget {
  final Rx<ImageDetail> item1;
  final int index;
  const _Item({required this.item1, required this.index});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    return Obx(() {
      ImageDetail item = item1.value;
      ImageApp? imageApp = item.idImage;

      Plant? plant = homeController.plantViews.firstWhereOrNull(
        (e) => e.id == item.idPlant,
      );

      PlantType? plantType = homeController.plantTypeViews.firstWhereOrNull(
        (e) => e.id == item.idPlantType,
      );

      PlantCondition? plantCondition = homeController.plantConditionViews
          .firstWhereOrNull((e) => e.id == item.idCondition);

      DateTime? createdAt = item.createdAt;
      String? formattedDate;
      if (createdAt != null) {
        formattedDate = DateFormat(
          'HH:mm:ss dd-MM-yyyy',
        ).format(createdAt.add(const Duration(hours: 7)));
      }
      return imageApp == null
          ? const ListTile(
            title: Text(
              "Không tìm thấy hình ảnh",
              style: TextStyle(color: Colors.red),
            ),
          )
          : InkWell(
            child: Container(
              margin: EdgeInsets.only(
                left: Get.width * 0.02,
                right: Get.width * 0.03,
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
                    height: Get.width * 0.25,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          "${Config.urlAPI}${imageApp.downloadUri}",
                        ),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  Container(
                    width: Get.width * 0.675,
                    decoration: BoxDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${plant != null ? plant.name : ''} ${plantType == null ? '' : '(${plantType.name})'}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        plantCondition == null
                            ? const SizedBox()
                            : Text("Sinh trưởng: ${plantCondition.name}"),
                        Text(
                          "Mô tả: ${item.description}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        formattedDate == null
                            ? const SizedBox()
                            : Text("Tạo lúc: $formattedDate"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            onTap: () async => await homeController.onClickImage(item, index),
          );
    });
  }
}
