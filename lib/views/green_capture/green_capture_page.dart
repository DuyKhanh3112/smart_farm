import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/objs/image.dart';
import 'package:smart_farm/objs/plant.dart';
import 'package:smart_farm/controller/green_capture/home_controller.dart';
import 'package:smart_farm/widgets/progress.dart';
import 'package:smart_farm/widgets/widgets.dart';
import 'package:intl/intl.dart';

class GreenCapturePage extends StatelessWidget {
  const GreenCapturePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
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
            child: ListView.separated(
              separatorBuilder: separatorBuilder,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _Item(item1: items[index], index: index);
              },
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
          : ListTile(
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                formattedDate == null
                    ? const SizedBox()
                    : Text("Tạo lúc: $formattedDate"),
                plant == null ? const SizedBox() : Text("Giống: ${plant.name}"),
                plantType == null
                    ? const SizedBox()
                    : Text("Loại hình ảnh: ${plantType.name}"),
                plantCondition == null
                    ? const SizedBox()
                    : Text("Sinh trưởng: ${plantCondition.name}"),
                Text("Mô tả: ${item.description}"),
              ],
            ),
            onTap: () async => await homeController.onClickImage(item, index),
          );
    });
  }
}
